//
//  PreProcessor.m
//  OCMAT
//
//  Created by mizu-bai on 2020/10/19.
//

#import "PreProcessor.h"

@implementation PreProcessor

- (id)initSourceFilePathWith: (NSString *)sourceFilePath {
    self = [super init];
    if(self) {
        self.sourceFileContent = sourceFilePath;
    }
    return self;
}

- (id)readSourceFile {
    NSString * error;
    self.sourceFileContent = [NSString stringWithContentsOfFile: self.sourceFilePath encoding: NSUTF8StringEncoding error: nil];
    if(error) {
        
    }
    return
}

@end
