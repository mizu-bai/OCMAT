//
//  MZLexer.h
//  OCMAT
//
//  Created by mizu-bai on 2021/3/23.
//
//

#import <Foundation/Foundation.h>

#import "type_codes.h"

NS_ASSUME_NONNULL_BEGIN

@interface MZLexer : NSObject

@property(nonatomic, copy) NSString *bufferString;

- (instancetype)init;

+ (instancetype)lexer;

- (void)readLine:(NSString *)line;

@end

NS_ASSUME_NONNULL_END
