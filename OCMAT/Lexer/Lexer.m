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
//        NSLog(@"%@", self.KeywordsDic);
        
        // init Mathematical Operators dictionary
        NSArray * mathematicalOperatorsObj = @[@"PLUS", @"MINUS", @"TIMES", @"MTIMES", @"RDIVIDE", @"MRDIVIDE", @"LDIVIDE", @"MLDIVIDE", @"POWER", @"MPOWER", @"TRANSPOSE", @"CTRANSPOSE"];
        NSArray * mathematicalOperatorsKey = @[@"+", @"-", @".*", @"*", @"./", @"/", @".\\", @"\\", @".^", @"^", @".'", @"'"];
        self.MathematicalOperatorsDic = [NSDictionary dictionaryWithObjects: mathematicalOperatorsObj forKeys: mathematicalOperatorsKey];
//        NSLog(@"%@", self.MathematicalOperatorsDic);
        
        // init Relational Operators dictionary
        NSArray * relationalOperatorsObj = @[@"EQ", @"NE", @"GT", @"GE", @"LT", @"LE"];
        NSArray * relationalOperatorsKey = @[@"==", @"~=", @">", @">=", @"<", @"<="];
        self.RelationalOperatorsDic = [NSDictionary dictionaryWithObjects: relationalOperatorsObj forKeys: relationalOperatorsKey];
//        NSLog(@"%@", self.RelationalOperatorsDic);
        
        // init Logical Operators dictionary
        NSArray * logicalOperatorsObj = @[@"AND", @"OR", @"SHORT_CIRCUIT_AND", @"SHORT_CIRCUIT_OR", @"NOT"];
        NSArray * logicalOperatorsKey = @[@"&", @"|", @"&&", @"||", @"~"];
        self.LogicalOperatorsDic = [NSDictionary dictionaryWithObjects: logicalOperatorsObj forKeys: logicalOperatorsKey];
//        NSLog(@"%@", self.LogicalOperatorsDic);
        
        // init Delimiters dictionary
        NSArray * delimitersObj = @[@"AT", @"DOT", @"DOT_DOT_DOT", @"COMMA", @"COLON", @"SEMICOLON", @"LEFT_PARENTHESE", @"RIGHT_PARENTHESE", @"LEFT_SQUARE_BRACKETS", @"RIGHT_SQUARE_BRACKETS", @"LEFT_CURLY_BRACKETS", @"RIGHT_CURLY_BRACKETS", @"PERCENT", @"LEFT_PERCENT_CURLY_BRACKET", @"RIGHT_PERCENT_CURLY_BRACKET", @"EXCLAMATION_POINT", @"QUESTION_MARK", @"SINGLE_QUOTE", @"DOUBLE_QUOTE", @"TILDE", @"EUQAL_SIGN", @"LEFT_ANGLE_BRACKET_AND_AMPERSAND", @"DOT_QUESTION_MARK"];
        NSArray * delimitersKey = @[@"@", @".", @"...", @",", @":", @";", @"(", @")", @"[", @"]", @"{", @"}", @"%", @"%{", @"%}", @"!", @"?", @"'", @"\"", @"~", @"=", @"< &", @".?"];
        self.DelimitersDic = [NSDictionary dictionaryWithObjects: delimitersObj forKeys: delimitersKey];
//        NSLog(@"%@", self.DelimitersDic);
    }
    
    // init Token
    self.Token = [[NSMutableDictionary alloc] init];
//    NSLog(@"%@", self.Token);
    
    return self;
}

- (id)isKeywordInLine:(NSString *)line AtIndex:(int)p {
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
        while(p + 1 < [line length] && isLetter([line characterAtIndex: p + 1])) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
        for(NSString * keyword in possibleKeywords) {
            if([currentString isEqual: keyword]) {
                return [self.KeywordsDic objectForKey: currentString];
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
        for(NSString * mathematicalOperator in possibleMathematicalOperators) {
            if([currentString isEqual: mathematicalOperator]) {
                return [self.MathematicalOperatorsDic objectForKey: currentString];
            }
        }
    } else {
        return [self.MathematicalOperatorsDic objectForKey: currentString];
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
        for(NSString * relationalOperator in possibleRelationalOperators) {
            if([currentString isEqual: relationalOperator]) {
                return [self.RelationalOperatorsDic objectForKey: currentString];
            }
        }
    } else {
        return [self.MathematicalOperatorsDic objectForKey: currentString];
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
        while(p + 1 < [line length] && !(isLetter([line characterAtIndex: p + 1]) && isNum([line characterAtIndex: p + 1]))) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
        for(NSString * logicalOperator in possibleLogicalOperators) {
            if([currentString isEqual: logicalOperator]) {
                return [self.LogicalOperatorsDic objectForKey: currentString];
            }
        }
    } else {
        return [self.LogicalOperatorsDic objectForKey: currentString];
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
        while(p + 1 < [line length] && !(isLetter([line characterAtIndex: p + 1]) && isNum([line characterAtIndex: p + 1]))) {
            p += 1;
            [currentString appendFormat: @"%c", [line characterAtIndex: p]];
        }
        for(NSString * delimiter in possibleDelimiters) {
            if([currentString isEqual: delimiter]) {
                return [self.DelimitersDic objectForKey: currentString];
            }
        }
    } else {
        return [self.DelimitersDic objectForKey: currentString];
    }
    return [NSNull null];
}

- (id)isConstInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    if(!isNum([line characterAtIndex: p])) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    while(p + 1 < [line length] && (isNum([line characterAtIndex: p + 1]) || [line characterAtIndex: p + 1] == '.' || [line characterAtIndex: p + 1] == 'E' || [line characterAtIndex: p + 1] == 'e' || [line characterAtIndex: p + 1] == '+' || [line characterAtIndex: p + 1] == '-')) {
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
        if(eCount > 1) {
            return [NSNull null];
        }
        if(dotCount > 1) {
            return [NSNull null];
        }
    }
    if([currentString hasSuffix: @"e"] || [currentString hasSuffix: @"E"]) {
        return [NSNull null];
    }
    return currentString;
}

- (id)isIdentifierInLine: (NSString *)line AtIndex: (int)p {
    if(p >= [line length]) {
        return [NSNull null];
    }
    if(!isLetter([line characterAtIndex: p])) {
        return [NSNull null];
    }
    NSMutableString * currentString = [NSMutableString stringWithFormat: @"%c", [line characterAtIndex: p]];
    while(p + 1 < [line length] && ((isLetter([line characterAtIndex: p + 1]) || isNum([line characterAtIndex: p + 1])))) {
        p += 1;
        [currentString appendFormat: @"%c", [line characterAtIndex: p]];
    }
    return currentString;
}

- (void)formTokenWith: (NSString *)type AndLiteral: (id)literal {
    [self.Token setObject: type forKey: literal];
}

- (void)clearToken {
    [self.Token removeAllObjects];
}

@end
