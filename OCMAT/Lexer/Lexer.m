//
//  Lexer.m
//  OCMAT
//
//  Created by mizu-bai on 2020/10/6.
//

#import "Lexer.h"

@implementation Lexer

- (id)init {
    self = [super init];
    if(self) {
        // init Keywords dictionary
        NSArray * keywordsObj = @[@"BREAK", @"CASE", @"CATCH", @"CLASSDEF", @"CONTINUE", @"ELSE", @"ELSEIF", @"END", @"FOR", @"FUNCTION", @"GLOBAL", @"IF", @"OTHERWISE", @"PARFOR", @"PERSISTENT", @"RETURN", @"SPMD", @"SWITCH", @"TRY", @"WHILE"];
        NSArray * keywordsKey = @[@"break", @"case", @"catch", @"classdef", @"continue", @"else", @"elseif", @"end", @"for", @"function", @"global", @"if", @"otherwise", @"parfor", @"persistent", @"return", @"spmd", @"switch", @"try", @"while"];
        self.KeywordsDic = [NSDictionary dictionaryWithObjects: keywordsObj forKeys: keywordsKey];
        
        // init Mathematical Operators dictionary
        NSArray * mathematicalOperatorsObj = @[@"PLUS", @"MINUS", @"TIMES", @"MTIMES", @"RDIVIDE", @"MRDIVIDE", @"LDIVIDE", @"MLDIVIDE", @"POWER", @"MPOWER", @"TRANSPOSE", @"CTRANSPOSE"];
        NSArray * mathematicalOperatorsKey = @[@"+", @"-", @".*", @"*", @"./", @"/", @".\\", @"\\", @".^", @"^", @".'", @"'"];
        self.MathematicalOperatorsDic = [NSDictionary dictionaryWithObjects: mathematicalOperatorsObj forKeys: mathematicalOperatorsKey];
        
        // init Relational Operators dictionary
        NSArray * relationalOperatorsObj = @[@"EQ", @"NE", @"GT", @"GE", @"LT", @"LE"];
        NSArray * relationalOperatorsKey = @[@"==", @"~=", @">", @">=", @"<", @"<="];
        self.RelationalOperatorsDic = [NSDictionary dictionaryWithObjects: relationalOperatorsObj forKeys: relationalOperatorsKey];
        
        // init Logical Operators dictionary
        NSArray * logicalOperatorsObj = @[@"AND", @"OR", @"SHORT_CIRCUIT_AND", @"SHORT_CIRCUIT_OR", @"NOT"];
        NSArray * logicalOperatorsKey = @[@"&", @"|", @"&&", @"||", @"~"];
        self.LogicalOperatorsDic = [NSDictionary dictionaryWithObjects: logicalOperatorsObj forKeys: logicalOperatorsKey];
        
        // init Delimiters dictionary
        NSArray * delimitersObj = @[@"AT", @"DOT", @"DOT_DOT_DOT", @"COMMA", @"COLON", @"SEMICOLON", @"LEFT_PARENTHESE", @"RIGHT_PARENTHESE", @"LEFT_SQUARE_BRACKETS", @"RIGHT_SQUARE_BRACKETS", @"LEFT_CURLY_BRACKETS", @"RIGHT_CURLY_BRACKETS", @"PERCENT", @"LEFT_PERCENT_CURLY_BRACKET", @"RIGHT_PERCENT_CURLY_BRACKET", @"EXCLAMATION_POINT", @"QUESTION_MARK", @"SINGLE_QUOTE", @"DOUBLE_QUOTE", @"TILDE", @"EUQAL_SIGN", @"LEFT_ANGLE_BRACKET_AND_AMPERSAND", @"DOT_QUESTION_MARK"];
        NSArray * delimitersKey = @[@"@", @".", @"...", @",", @":", @";", @"(", @")", @"[", @"]", @"{", @"}", @"%", @"%{", @"%}", @"!", @"?", @"'", @"\"", @"~", @"=", @"< &", @".?"];
        self.DelimitersDic = [NSDictionary dictionaryWithObjects: delimitersObj forKeys: delimitersKey];
    }
        
    return self;
}

- (id)isKeywordInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    // first charactor
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    NSMutableArray * possibleKeywords = [[NSMutableArray alloc] init];
    // narrow the range
    for(NSString * keyword in [self.KeywordsDic allKeys]) {
        if([keyword hasPrefix: currentString]) {
            [possibleKeywords addObject: keyword];
        }
    }
    if([possibleKeywords count] != 0) {
        while(p + 1 < [line length] && isalpha([line characterAtIndex: p + 1])) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
        for(NSString * keyword in possibleKeywords) {
            if([currentString isEqual: keyword]) {
                NSDictionary * res = @{@"type": [self.KeywordsDic objectForKey: currentString], @"literal": @"-", @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
                return res;
            }
        }
    }
    return [NSNull null];
}

- (id)isMathematicalOperatorInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    NSMutableArray * possibleMathematicalOperators = [[NSMutableArray alloc] init];
    if([currentString isEqual: @"."]) {
        [possibleMathematicalOperators addObjectsFromArray: @[@".*", @"./", @".\\", @".^", @".'"]];
        if(p + 1 >= [line length]) {
            return [NSNull null];
        }
        p += 1;
        [currentString appendFormat: @"%c", [line characterAtIndex: p]];
    }
    if([[self.MathematicalOperatorsDic allKeys] containsObject: currentString]) {
            NSDictionary * res = @{@"type": [self.MathematicalOperatorsDic  objectForKey: currentString], @"literal": @"-", @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
            return res;
    }
    return [NSNull null];
}

- (id)isRelationalOperatorInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    NSMutableArray * possibleRelationalOperators = [[NSMutableArray alloc] init];
    if([currentString isEqual: @">"] || [currentString isEqual: @"<"] || [currentString isEqual: @"="] || [currentString isEqual: @"~"]) {
        for(NSString * relationalOperator in [self.RelationalOperatorsDic allKeys]) {
            if([relationalOperator hasPrefix: currentString]) {
                [possibleRelationalOperators addObject: relationalOperator];
            }
        }
        if(p + 1 < [line length]) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
    }
    if([[self.RelationalOperatorsDic allKeys] containsObject: currentString]) {
        NSDictionary * res = @{@"type": [self.RelationalOperatorsDic objectForKey: currentString], @"literal": @"-", @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
        return res;
    }
    return [NSNull null];
}

- (id)isLogicalOperatorInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    NSMutableArray * possibleLogicalOperators = [[NSMutableArray alloc] init];
    if([currentString isEqual: @"&"] || [currentString isEqual: @"|"]) {
        for(NSString * logicalOperator in [self.LogicalOperatorsDic allKeys]) {
            if([logicalOperator hasPrefix: currentString]) {
                [possibleLogicalOperators addObject: logicalOperator];
            }
        }
        while(p + 1 < [line length] && !isalnum([line characterAtIndex: p + 1])) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
    }
    if([[self.LogicalOperatorsDic allKeys] containsObject: currentString]) {
        NSDictionary * res = @{@"type": [self.LogicalOperatorsDic objectForKey: currentString], @"literal": @"-", @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
        return res;
    }
    return [NSNull null];
}

- (id)isDelimiterInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    NSMutableArray * possibleDelimiters = [[NSMutableArray alloc] init];
    if([currentString isEqual: @"%"] || [currentString isEqual: @"."] || [currentString isEqual: @"<"]) {
        for(NSString * delimiter in [self.DelimitersDic allKeys]) {
            if([delimiter hasPrefix: delimiter]) {
                [possibleDelimiters addObject: delimiter];
            }
        }
        while(p + 1 < [line length] && !isalnum([line characterAtIndex: p + 1])) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
    }
    if([[self.DelimitersDic allKeys] containsObject: currentString]) {
        NSDictionary * res = @{@"type": [self.DelimitersDic objectForKey: currentString], @"literal": @"-", @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
        return res;
    }
    return [NSNull null];
}

- (id)isNumberConstInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    if(!(isdigit([line characterAtIndex: p]) || [line characterAtIndex: p] == '+' || [line characterAtIndex: p] == '-')) {
        return [NSNull null];
    }
    while(p + 1 < [line length] && (isnumber([line characterAtIndex: p + 1]) || [line characterAtIndex: p + 1] == 'E' || [line characterAtIndex: p + 1] == 'e' || [line characterAtIndex: p + 1] == '+' || [line characterAtIndex: p + 1] == '-' || [line characterAtIndex: p + 1] == '.')) {
        p += 1;
        [currentString appendFormat: @"%c", [line characterAtIndex: p]];
    }
    int dotCount = 0;
    int eCount   = 0;
    for(int i = 0; i < [currentString length]; i++) {
        NSString * currentCharacter = [NSMutableString stringWithFormat: @"%c", [currentString characterAtIndex: i]];
        if([currentCharacter isEqual: @"."]) {
            dotCount += 1;
        } else if([currentCharacter isEqual: @"e"] || [currentCharacter isEqual: @"E"]) {
            eCount += 1;
            dotCount = 0;
        }
        if(eCount > 1 || dotCount > 1) {
            return [NSNull null];
        }
    }
    if([currentString hasSuffix: @"e"] || [currentString hasSuffix: @"E"]) {
        return [NSNull null];
    }
    NSDictionary * res = @{@"type": @"CONST", @"literal": currentString, @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
    return res;
}

- (id)isStringConstInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    int singleQuoteCount = 0;
    int doubleQuoteCount = 0;
    if([line characterAtIndex: p] == '\'') {
        singleQuoteCount = 1;
    } else if([line characterAtIndex: p] == '\"') {
        doubleQuoteCount = 1;
    } else {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    while(p + 1 < [line length]) {
        p += 1;
        [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        if([line characterAtIndex: p] == '\'') {
            singleQuoteCount += 1;
        } else if([line characterAtIndex: p] == '\"') {
            doubleQuoteCount += 1;
        }
        if(singleQuoteCount == 2 || doubleQuoteCount == 2) {
            NSDictionary * res = @{@"type": @"CONST", @"literal": currentString, @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
            return res;
        }
    }
    return [NSNull null];
}

- (id)isIdentifierInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    if(!isalpha([line characterAtIndex: p])) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    while(p + 1 < [line length] && isalnum([line characterAtIndex: p + 1])) {
        p += 1;
        [currentString appendFormat: @"%c", [line characterAtIndex: p]];
    }
    NSDictionary * res = @{@"type": @"IDENTIFIER", @"literal": currentString, @"movingStep": [NSNumber numberWithInt: (int)[currentString length]]};
    return res;
}

@end
