//
//  MZLexer.m
//  OCMAT
//
//  Created by mizu on 2021/3/23.
//
//

#import "MZLexer.h"

@interface MZLexer () {

}

@property(nonatomic, copy) NSDictionary *keywordsDict;
@property(nonatomic, copy) NSDictionary *operatorsDict;
@property(nonatomic, copy) NSDictionary *delimitersDict;

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
        };

        // set DelimiterDict
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
                @"=": @EQUAL,
        };
    }
    return self;
}

+ (instancetype)lexer {
    return [[self alloc] init];
}

- (void)readLine:(NSString *)line {
    self.bufferString = line;
}


@end
