//
//  main.m
//  OCMAT
//
//  Created by mizu-bai on 2020/10/6.
//

#import <Foundation/Foundation.h>
#import "PreProcessor/PreProcessor.h"
#import "Lexer/Lexer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Read File
        NSString * content = [[NSString alloc] init];
        if(argc != 2) {
            NSLog(@"Invaild Input Parameters!");
            exit(-1);
        } else {
            NSString * filePath = [NSString stringWithFormat: @"%s", argv[1]];
            NSFileManager * fileManager = [NSFileManager defaultManager];
            if([fileManager fileExistsAtPath: filePath]) {
                NSData * data = [NSData dataWithContentsOfFile: filePath];
                content = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            } else {
                NSLog(@"No Such File Exists At \"%@\"!", filePath);
                exit(-1);
            }
        }
        // PreProcessor
        PreProcessor * preProcessor = [[PreProcessor alloc] initWithSourceContent: content];
        [preProcessor preProcess];
        NSString * preProcessedContent = [preProcessor preProcessedContent];
        // Lexer
        Lexer * lexer = [[Lexer alloc] init];
        int p = 0;
        NSMutableArray * tokenArray = [[NSMutableArray alloc] init];
        while(p < [preProcessedContent length]) {
            while(isspace([preProcessedContent characterAtIndex: p])) {
                if(p + 1 < [preProcessedContent length]) {
                    p += 1;
                }
            }
            NSMutableArray * res = [[NSMutableArray alloc] init];
            if(isalpha([preProcessedContent characterAtIndex: p])) {
                [res addObject: [lexer isKeywordInLine:              preProcessedContent AtIndex: p]];
                [res addObject: [lexer isIdentifierInLine:           preProcessedContent AtIndex: p]];
            } else if(isdigit([preProcessedContent characterAtIndex: p])) {
                [res addObject: [lexer isNumberConstInLine:          preProcessedContent AtIndex: p]];
            } else if(!isalnum([preProcessedContent characterAtIndex: p])) {
                [res addObject: [lexer isNumberConstInLine:          preProcessedContent AtIndex: p]];
                [res addObject: [lexer isStringConstInLine:          preProcessedContent AtIndex: p]];
                [res addObject: [lexer isDelimiterInLine:            preProcessedContent AtIndex: p]];
                [res addObject: [lexer isMathematicalOperatorInLine: preProcessedContent AtIndex: p]];
                [res addObject: [lexer isRelationalOperatorInLine:   preProcessedContent AtIndex: p]];
                [res addObject: [lexer isLogicalOperatorInLine:      preProcessedContent AtIndex: p]];
            } else {
                NSLog(@"Cannot Determine Type of %c At %d!", [preProcessedContent characterAtIndex: p], p);
                exit(-1);
            }
            int isAllNull = 1;
            for(id obj in res) {
                if(![obj isEqual: [NSNull null]]) {
                    NSString * type         = [obj objectForKey: @"type"];
                    NSString * literal      = [obj objectForKey: @"literal"];
                    NSString * currentToken = [NSString stringWithFormat: @"<%@, %@>", type, literal];
                    [tokenArray addObject: currentToken];
                    p += [[obj objectForKey: @"movingStep"] intValue];
                    isAllNull = 0;
                    break;
                }
            }
            if(isAllNull == 1) {
                p += 1;
            }
        }
        NSLog(@"%@", tokenArray);
    }
    return 0;
}
