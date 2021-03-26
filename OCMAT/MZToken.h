//
// Created by mizu-bai on 2021/3/26.
//

#import <Foundation/Foundation.h>

#import "typeCodes.h"


@interface MZToken : NSObject

@property (nonatomic, assign) int typeCode;
@property (nonatomic, strong) NSString *literal;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)tokenWithDictionary:(NSDictionary *)dictionary;
@end