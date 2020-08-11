//
//  Workspace.m
//  ocmat
//
//  Created by mizu-bai on 2020/8/8.
//  Copyright © 2020 mizu-bai. All rights reserved.
//

#import "Workspace.h"

@implementation Workspace

- (id)init {

    self = [super init];
    
    if(self) {
        
        NSLog(@"Class EuqationParameter initialized.");
        
    }

    return self;
    
}

- (void)updateVaribaleDicWithValue:(NSString *)varibaleValue Name:(NSString *)varibleName {

    [self.bufferVaribleDic setObject: varibaleValue forKey: varibleName];
    
}

- (void)clearWorkspace {
    
    [self.bufferVaribleDic removeAllObjects];
    
}

@end
