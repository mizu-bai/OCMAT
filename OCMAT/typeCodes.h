//
//  typeCodes.h
//  OCMAT
//
//  Created by mizu-bai on 2021/3/23.
//
//

#ifndef typeCodes_h
#define typeCodes_h

/**
 * In this header file, macros with the type codes are defined.
 * The 1st digit in type code defines its type, including identifier, constants, keywords, operators, and delimiters.
 * The 2nd digit in type code defines its sub type.
 * The last two digits are given by order.
 */

/// identifiers
#define IDENTIFIER                          0000

/// constants
// numeric constants
#define CONST_REAL                          1000
#define CONST_COMPLEX                       1001
#define INFINITY                            1002
#define NOT_A_NUMBER                        1003
// character and string constants
#define CONST_STRING                        1100
#define CONST_CHARACTER                     1101

/// keywords
#define BREAK                               2000
#define CASE                                2001
#define CATCH                               2002
#define CLASSDEF                            2003
#define CONTINUE                            2004
#define ELSE                                2005
#define ELSEIF                              2006
#define END                                 2007
#define FOR                                 2008
#define FUNCTION                            2009
#define GLOBAL                              2010
#define IF                                  2011
#define OTHERWISE                           2012
#define PARFOR                              2013
#define PERSISTENT                          2014
#define RETURN                              2015
#define SPMD                                2016
#define SWITCH                              2017
#define TRY                                 2018
#define WHILE                               2019

/// operators
// mathematical Operators
#define PLUS                                3001
#define MINUS                               3002
#define DOT_ASTERISK                        3003
#define ASTERISK                            3004
#define DOT_SLASH                           3005
#define SLASH                               3006
#define DOT_BACKSLASH                       3007
#define BACKSLASH                           3008
#define DOT_CARAT                           3009
#define CARAT                               3010
#define DOT_APOSTROPHE                      3011
#define APOSTROPHE                          3012
// relational operators
#define DOUBLE_EQUAL                        3100
#define TILDE_EQUAL                         3101
#define GREATER_THAN                        3102
#define GREATER_EQUAL                       3103
#define LESS_THAN                           3104
#define LESS_EQUAL                          3105
// logical operators
#define AMPERSAND                           3200
#define VERTICAL_PIPE                       3201
#define DOUBLE_AMPERSAND                    3202
#define DOUBLE_VERTICAL_PIPE                3203
#define TILDE                               3204
// assign
#define EQUAL                               3300

/// delimiters
#define AT                                  4001
#define DOT                                 4002
#define DOTS                                4003
#define COMMA                               4004
#define COLON                               4005
#define SEMICOLON                           4006
#define OPEN_PARENTHESIS                    4007
#define CLOSE_PARENTHESIS                   4008
#define OPEN_SQUARE_BRACKET                 4009
#define CLOSE_SQUARE_BRACKET                4010
#define OPEN_CURLY_BRACKET                  4011
#define CLOSE_CURLY_BRACKET                 4012
#define PERCENT                             4013
#define OPEN_PERCENT_CURLY_BRACKET          4014
#define CLOSE_PERCENT_CURLY_BRACKET         4015
#define EXCLAMATION                         4016
#define QUESTION                            4017
// APOSTROPHE (symbol "'") is also a symbol in operators
// #define APOSTROPHE                       4018
#define QUOTATION                           4019
// TILDE (symbol "~") is also a symbol in operators
// #define TILDE                            4020

#endif /* typeCodes_h */
