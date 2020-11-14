//
//  PreProcessor.h
//  OCMAT
//
//  Created by mizu-bai on 2020/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreProcessor : NSObject

@property NSString * sourceContent;
@property NSString * preProcessedContent;

- (id)initWithSourceContent: (NSString *)inputSourceContent;
- (void)preProcess;

@end

NS_ASSUME_NONNULL_END
