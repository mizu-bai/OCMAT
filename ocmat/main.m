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
        Lexer * lexer = [[Lexer alloc] init];
        // test examples for lexer
        int p = 0;
        int i = 0;
        for(NSString * keyword in [[lexer KeywordsDic] allKeys]) {
            NSLog(@"%d %@ <%@, ->", i, keyword, [lexer isKeywordInLine: keyword AtIndex: p]);
            i += 1;
        }
        for(NSString * mathematicalOperator in [[lexer MathematicalOperatorsDic] allKeys]) {
            NSLog(@"%d %@ <%@, ->", i, mathematicalOperator, [lexer isMathematicalOperatorInLine: mathematicalOperator AtIndex: p]);
            i += 1;
        }
        for(NSString * relationalOperator in [[lexer RelationalOperatorsDic] allKeys]) {
            NSLog(@"%d %@ <%@, ->", i, relationalOperator, [lexer isRelationalOperatorInLine: relationalOperator AtIndex: p]);
            i += 1;
        }
        for(NSString * logicalOperator in [[lexer LogicalOperatorsDic] allKeys]) {
            NSLog(@"%d %@ <%@, ->", i, logicalOperator, [lexer isLogicalOperatorInLine: logicalOperator AtIndex: p]);
            i += 1;
        }
        for(NSString * delimiter in [[lexer DelimitersDic] allKeys]) {
            NSLog(@"%d %@ <%@, ->", i, delimiter, [lexer isDelimiterInLine:  delimiter AtIndex: p]);
            i += 1;
        }
        NSString * constant = @"114.514E+19.19";
        id resOfConst = [lexer isConstInLine: constant AtIndex: p];
        if([resOfConst isEqual: [NSNull null]]) {
            NSLog(@"%d %@ <%@, %@>", i, constant, resOfConst, constant);
        } else {
            NSLog(@"%d %@ <%@, %@>", i, constant, @"CONST", constant);
        }
        i += 1;
        NSString * identifier = @"a1919810";
        id resOfIdentifier = [lexer isIdentifierInLine: identifier AtIndex: p];
        if([resOfIdentifier isEqual: [NSNull null]]) {
            NSLog(@"%d %@ <%@, %@>", i, identifier, resOfIdentifier, identifier);
        } else {
            NSLog(@"%d %@ <%@, %@>", i, identifier, @"IDENTIFIER", identifier);
        }
        i += 1;
    }
    return 0;
}
