//
//  main.m
//  OCMAT
//
//  Created by mizu-bai on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import "MZLexer.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        /// file management
        char temp[128];
        printf("Please input the path of source code file: ");
        scanf("%s", temp);
        NSString *path = [NSString stringWithUTF8String:temp];
        printf("File path is: %s\n", [path UTF8String]);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            printf("No such file at %s", [path UTF8String]);
            return 1;
        }

        /// read content of file
        NSString *content = [NSString stringWithContentsOfFile:path];
        printf("Contents of file:\n%s\n", [content UTF8String]);
        NSArray<NSString *> *arrayLines = [content componentsSeparatedByString:@"\n"];

        /// preprocessor
        // delete blank lines
        NSMutableArray *linesM = [NSMutableArray array];
        for (NSString *line in arrayLines) {
            NSMutableString *clearString = [NSMutableString string];
            for (int i = 0; i < [line length]; i++) {
                NSMutableString *curChar = [[line substringWithRange:NSMakeRange((NSUInteger) i, 1)] mutableCopy];
                // replace tab with space
                if ([curChar isEqualToString:@"\t"]) {
                    curChar = [@" " mutableCopy];
                }
                // multi space
                if (!([clearString hasSuffix:@" "] && [curChar isEqualToString:@" "]) && !([clearString length] == 0 && [curChar isEqualToString:@" "])) {
                    clearString = [[clearString stringByAppendingString:curChar] mutableCopy];
                }
            }
            // blank line
            if ([clearString length] > 0) {
                [linesM addObject:clearString];
            }
        }
        arrayLines = linesM;

        /// lexer
        MZLexer *lexer = [MZLexer lexer];
        printf("Preprocessed result:\n");
        for (int i = 0; i < [arrayLines count]; ++i) {
            [lexer readLine:arrayLines[(NSUInteger) i]];
            printf("%2d | %s\n", i + 1, [lexer.bufferString UTF8String]);
        }
        // automate selector
        NSLog(@"%d", [lexer automateSelectorInLine:@"clear" AtIndexOfChar:0]);
    }
    return 0;
}
