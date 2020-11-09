//
//  Lexer.h
//  OCMAT
//
//  Created by mizu-bai on 2020/10/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Lexer : NSObject

@property NSDictionary        * KeywordsDic;
@property NSDictionary        * MathematicalOperatorsDic;
@property NSDictionary        * RelationalOperatorsDic;
@property NSDictionary        * LogicalOperatorsDic;
@property NSDictionary        * DelimitersDic;

- (id)init;
- (id)isKeywordInLine:              (NSString *)line AtIndex: (int)p;
- (id)isMathematicalOperatorInLine: (NSString *)line AtIndex: (int)p;
- (id)isRelationalOperatorInLine:   (NSString *)line AtIndex: (int)p;
- (id)isLogicalOperatorInLine:      (NSString *)line AtIndex: (int)p;
- (id)isDelimiterInLine:            (NSString *)line AtIndex: (int)p;
- (id)isNumberConstInLine:          (NSString *)line AtIndex: (int)p;
- (id)isStringConstInLine:          (NSString *)line AtIndex: (int)p;
- (id)isIdentifierInLine:           (NSString *)line AtIndex: (int)p;

@end

NS_ASSUME_NONNULL_END
