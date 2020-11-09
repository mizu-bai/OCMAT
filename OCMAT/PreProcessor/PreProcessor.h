//
//  PreProcessor.h
//  OCMAT
//
//  Created by mizu-bai on 2020/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreProcessor : NSObject

@property NSString * sourceFilePath;
@property NSString * sourceFileContent;
@property NSString * preProcessedContent;

- (id)initSourceFilePathWith: (NSString *)sourceFilePath;
- (id)readSourceFile;

@end

NS_ASSUME_NONNULL_END
