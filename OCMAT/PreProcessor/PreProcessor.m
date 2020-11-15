//
//  PreProcessor.m
//  OCMAT
//
//  Created by mizu-bai on 2020/10/19.
//

#import "PreProcessor.h"

@implementation PreProcessor

- (id)initWithSourceContent: (NSString *)inputSourceContent {
    self = [super init];
    if(self) {
        self.sourceContent = inputSourceContent;
    }
    return self;
}

- (void)preProcess {
    NSArray * contentItems = [self.sourceContent componentsSeparatedByString: @"\n"];
    NSMutableArray * res = [[NSMutableArray alloc] init];
    int isInSingleLineComment = 0;
    int isInMultiLineComment = 0;
    for(NSString * item in contentItems) {
        NSMutableString * newLine = [[NSMutableString alloc] init];
        int p = 0;
        while(p < [item length]) {
            if([item characterAtIndex: p] == '%') {
                if(p + 1 < [item length]) {
                    NSString * nextChar = [NSString stringWithFormat: @"%c", [item characterAtIndex: p + 1]];
                    if([nextChar isEqual: @"{"]) {
                        // Start of Multi Line Comment
                        isInMultiLineComment += 1;
                    } else if([nextChar isEqual: @"}"]) {
                        // End if Multi Line Comment
                        isInMultiLineComment -= 1;
                    } else {
                        // Single Line Comment
                        isInSingleLineComment = 1;
                    }
                }
            }
            [newLine appendFormat: @"%c", [item characterAtIndex: p]];
            p += 1;
        }
        if(isInSingleLineComment == 1) {
            [res addObject: @""];
            isInSingleLineComment = 0;
            continue;
        }
        if(isInMultiLineComment == 0) {
            if([newLine hasPrefix: @"%}"]) {
                [res addObject: [newLine substringFromIndex: 2]];
            } else {
                [res addObject: newLine];
            }
        } else if(isInMultiLineComment == 1) {
            [res addObject: @""];
            continue;
        }
    }
    if(isInMultiLineComment != 0) {
        NSLog(@"Unterminated Comment!");
        exit(-1);
    }
    self.preProcessedContent = [res componentsJoinedByString: @"\n"];
}

@end
