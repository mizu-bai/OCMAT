//
//  Workspace.h
//  ocmat
//
//  Created by mizu-bai on 2020/8/8.
//  Copyright © 2020 mizu-bai. All rights reserved.
//

#ifndef Workspace_h
#define Workspace_h

#import <Foundation/Foundation.h>

@interface Workspace: NSObject {
        
}

@property NSMutableArray *varibleNames;
@property NSMutableArray *varibleValues;
@property NSMutableDictionary *bufferVaribleDic;
@property NSDictionary *varibleDic;

- (id)init;
- (void)updateVaribaleDicWithValue: (NSString *)varibaleValue Name: (NSString *)varibleName;
- (void)clearWorkspace;

@end

#endif /* Workspace_h */
