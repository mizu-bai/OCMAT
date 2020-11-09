//
//  main.m
//  OCMAT
//
//  Created by mizu-bai on 2020/10/6.
//

#import <Foundation/Foundation.h>
#import "Lexer/Lexer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString * content = @"clear; clc; c = [0.0218, 0.0547, 0.111, 0.220, 0.329, 0.439, 0.550, 0.740]; gamma = [65.97, 57.69, 50.93, 44.35, 40.88, 36.35, 34.83, 31.63]; lgc = log10(c); figure(1); plot(lgc, gamma, 'ro'); hold on; p = polyfit(lgc, gamma, 1); plot(lgc, polyval(p, lgc), 'b-'); hold off; figure(2);";
        Lexer * lexer = [[Lexer alloc] init];
        int p = 0;
        NSMutableArray * tokenArray = [[NSMutableArray alloc] init];
        while(p < [content length]) {
//            while([content characterAtIndex: p] == ' ' || iscntrl([content characterAtIndex: p])) {
            while([content characterAtIndex: p] == ' ' || [content characterAtIndex: p] == '\n' || [content characterAtIndex: p] == '\t') {
                if(p + 1 >= [content length]) {
                    break;
                } else {
                    p += 1;
                }
            }
            NSMutableArray * res = [[NSMutableArray alloc] init];
            if(isalpha([content characterAtIndex: p])) {
                [res addObject: [lexer isKeywordInLine:              content AtIndex: p]];
                [res addObject: [lexer isIdentifierInLine:           content AtIndex: p]];
            } else if(isdigit([content characterAtIndex: p])) {
                [res addObject: [lexer isNumberConstInLine:          content AtIndex: p]];
            } else if(!isalnum([content characterAtIndex: p])) {
                [res addObject: [lexer isNumberConstInLine:          content AtIndex: p]];
                [res addObject: [lexer isStringConstInLine:          content AtIndex: p]];
                [res addObject: [lexer isDelimiterInLine:            content AtIndex: p]];
                [res addObject: [lexer isMathematicalOperatorInLine: content AtIndex: p]];
                [res addObject: [lexer isRelationalOperatorInLine:   content AtIndex: p]];
                [res addObject: [lexer isLogicalOperatorInLine:      content AtIndex: p]];
            } else {
                NSLog(@"Cannot Determine Type of %c At %d!", [content characterAtIndex: p], p);
                exit(-1);
            }
            for(id obj in res) {
                if(![obj isEqual: [NSNull null]]) {
                    NSString * type         = [obj objectForKey: @"type"];
                    NSString * literal      = [obj objectForKey: @"literal"];
                    NSString * currentToken = [NSString stringWithFormat: @"<%@, %@>", type, literal];
                    [tokenArray addObject: currentToken];
                    p += [[obj objectForKey: @"movingStep"] intValue];
                    break;
                }
            }
        }
        NSLog(@"%@", tokenArray);
    }
    return 0;
}
