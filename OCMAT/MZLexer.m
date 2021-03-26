//
//  MZLexer.m
//  OCMAT
//
//  Created by mizu-bai on 2021/3/23.
//
//

#import "MZLexer.h"

@interface MZLexer () {

}

@property(nonatomic, copy) NSDictionary *keywordsDict;
@property(nonatomic, copy) NSDictionary *operatorsDict;
@property(nonatomic, copy) NSDictionary *delimitersDict;

@property(nonatomic, copy) NSSet *operatorsCharSet;
@property(nonatomic, copy) NSSet *delimitersCharSet;

@end

@implementation MZLexer
- (instancetype)init {
    self = [super init];
    if (self) {
        // set KeywordDict
        self.keywordsDict = @{
                @"break": @BREAK,
                @"case": @CASE,
                @"catch": @CATCH,
                @"classdef": @CLASSDEF,
                @"continue": @CONTINUE,
                @"else": @ELSE,
                @"elseif": @ELSEIF,
                @"end": @END,
                @"for": @FOR,
                @"function": @FUNCTION,
                @"global": @GLOBAL,
                @"if": @IF,
                @"otherwise": @OTHERWISE,
                @"parfor": @PARFOR,
                @"persistent": @PERSISTENT,
                @"return": @RETURN,
                @"spmd": @SPMD,
                @"switch": @SWITCH,
                @"try": @TRY,
                @"while": @WHILE,
        };

        // set operatorDict
        self.operatorsDict = @{
                // mathematical
                @"+": @PLUS,
                @"-": @MINUS,
                @".*": @DOT_ASTERISK,
                @"*": @ASTERISK,
                @"./": @DOT_SLASH,
                @"/": @SLASH,
                @".\\": @DOT_BACKSLASH,
                @"\\": @BACKSLASH,
                @".^": @DOT_CARAT,
                @"^": @CARAT,
                @".'": @DOT_APOSTROPHE,
                @"'": @APOSTROPHE,
                // relational
                @"==": @DOUBLE_EQUAL,
                @"~=": @TILDE_EQUAL,
                @">": @GREATER_THAN,
                @">=": @GREATER_EQUAL,
                @"<": @LESS_THAN,
                @"<=": @LESS_EQUAL,
                // logical
                @"&": @AMPERSAND,
                @"|": @VERTICAL_PIPE,
                @"&&": @DOUBLE_AMPERSAND,
                @"||": @DOUBLE_VERTICAL_PIPE,
                @"~": @TILDE,
                // assign
                @"=": @EQUAL,
        };

        // set delimiterDict
        self.delimitersDict = @{
                // delimiters
                @"@": @AT,
                @".": @DOT,
                @"...": @DOTS,
                @",": @COMMA,
                @":": @COLON,
                @";": @SEMICOLON,
                @"(": @OPEN_PARENTHESIS,
                @")": @CLOSE_PARENTHESIS,
                @"[": @OPEN_SQUARE_BRACKET,
                @"]": @CLOSE_SQUARE_BRACKET,
                @"{": @OPEN_CURLY_BRACKET,
                @"}": @CLOSE_CURLY_BRACKET,
                @"%": @PERCENT,
                @"%{": @OPEN_PERCENT_CURLY_BRACKET,
                @"%}": @CLOSE_PERCENT_CURLY_BRACKET,
                @"!": @EXCLAMATION,
                @"?": @QUESTION,
                @"\"": @QUOTATION,
        };
        // set operatorsCharSet
        NSMutableArray *arrayCharSetM = [NSMutableArray array];
        for (NSString *operator in self.operatorsDict.allKeys) {
            for (int i = 0; i < [operator length]; ++i) {
                [arrayCharSetM addObject:[operator substringWithRange:NSMakeRange((NSUInteger) i, 1)]];
            }
        }
        self.operatorsCharSet = [NSSet setWithArray:[arrayCharSetM copy]];
        // set delimitersCharSet
        [arrayCharSetM removeAllObjects];
        for (NSString *delimiter in self.delimitersDict.allKeys) {
            for (int i = 0; i < [delimiter length]; ++i) {
                [arrayCharSetM addObject:[delimiter substringWithRange:NSMakeRange((NSUInteger) i, 1)]];
            }
        }
        self.delimitersCharSet = [NSSet setWithArray:[arrayCharSetM copy]];
    }
    return self;
}

+ (instancetype)lexer {
    return [[self alloc] init];
}

- (void)readLine:(NSString *)line {
    self.bufferString = line;
}

- (enum MZAutomateType)automateSelectorInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    NSString *firstChar = [line substringWithRange:NSMakeRange(index, 1)];
    enum MZAutomateType automateType = MZAutomateUnknown;
    if (isnumber([firstChar characterAtIndex:0])) {
        automateType = MZAutomateConstantNumber;
    } else if ([firstChar isEqualToString:@"'"] || [firstChar isEqualToString:@"\""]) {
        automateType = MZAutomateConstantCharacterAndString;
    } else if (isalpha([firstChar characterAtIndex:0])) {
        automateType = MZAutomateIdentifierAndKeyword;
    } else if ([self.operatorsCharSet containsObject:firstChar]) {
        automateType = MZAutomateOperator;
    } else if ([self.delimitersCharSet containsObject:firstChar]) {
        automateType = MZAutomateDelimiter;
    }
    return automateType;
}

- (NSDictionary *)AutomateIdentifierAndKeywordInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}

- (NSDictionary *)AutomateConstantNumberInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}

- (NSDictionary *)AutomateConstantCharacterAndStringInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}

- (NSDictionary *)AutomateOperatorMathematicalInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}

- (NSDictionary *)AutomateOperatorLogicalInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}

- (NSDictionary *)AutomateOperatorRelationalInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}

- (NSDictionary *)AutomateDelimiterInLine:(NSString *)line AtIndexOfChar:(NSUInteger)index {
    return nil;
}


@end
