//
//  main.m
//  ocmat
//
//  Created by mizu-bai on 2020/8/5.
//  Copyright © 2020 mizu-bai. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]) {
    
    @autoreleasepool {
        
        NSLog(@"OCMAT starts.");
        printf("\n");
        
        BOOL exit_flag = NO;
        
        while(exit_flag == NO) {
            
            printf(">>  "); // Prompt
            char cInput[128];
            scanf("%s", cInput);
            NSString *nsInput = [[NSString alloc] initWithUTF8String: cInput];
            
            // Deal with inputs ...
            
            // The following codes is a demo.
            
            if([nsInput isEqualToString: @"exit"]) {
                
                exit_flag = YES;
                
            } else {
                
                NSString *ans = [[NSString alloc] initWithString: nsInput];
                printf("    ans = %s\n", [ans UTF8String]);
            
            }
        }

        printf("\n");
        NSLog(@"OCMAT exits.");
        
    }
    
    return 0;
    
}
