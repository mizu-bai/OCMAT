//
//  MZLexer.h
//  OCMAT
//
//  Created by mizu-bai on 2021/3/23.
//
//

#import <Foundation/Foundation.h>

#import "typeCodes.h"

enum MZAutomateType {
    MZAutomateUnknown = 0,
    MZAutomateIdentifierAndKeyword = 1,
    MZAutomateConstantNumber = 2,
    MZAutomateConstantCharacterAndString = 4,
    MZAutomateOperator = 8,
    MZAutomateDelimiter = 16,
};

NS_ASSUME_NONNULL_BEGIN

@interface MZLexer : NSObject

@property(nonatomic, copy) NSString *bufferString;

- (instancetype)init;

+ (instancetype)lexer;

- (void)readLine:(NSString *)line;

- (enum MZAutomateType)automateSelectorInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateIdentifierAndKeywordInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateConstantNumberInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateConstantCharacterAndStringInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateOperatorMathematicalInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateOperatorLogicalInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateOperatorRelationalInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

- (NSDictionary *)AutomateDelimiterInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
