//
//  Lexer.h
//  OCMAT
//
//  Created by mizu-bai on 2020/10/6.
//

#import <Foundation/Foundation.h>

#import "isLetter.h"
#import "isNum.h"

NS_ASSUME_NONNULL_BEGIN

@interface Lexer : NSObject

@property NSDictionary        * KeywordsDic;
@property NSDictionary        * MathematicalOperatorsDic;
@property NSDictionary        * RelationalOperatorsDic;
@property NSDictionary        * LogicalOperatorsDic;
@property NSDictionary        * DelimitersDic;
@property NSMutableDictionary * Token;

- (id)init;
- (id)isKeywordInLine:              (NSString *)line AtIndex:    (int)p;
- (id)isMathematicalOperatorInLine: (NSString *)line AtIndex:    (int)p;
- (id)isRelationalOperatorInLine:   (NSString *)line AtIndex:    (int)p;
- (id)isLogicalOperatorInLine:      (NSString *)line AtIndex:    (int)p;
- (id)isDelimiterInLine:            (NSString *)line AtIndex:    (int)p;
- (id)isConstInLine:                (NSString *)line AtIndex:    (int)p;
- (id)isIdentifierInLine:           (NSString *)line AtIndex:    (int)p;
- (void)formTokenWith:              (NSString *)type AndLiteral: (id)literal;
- (void)clearToken;

@end

NS_ASSUME_NONNULL_END
