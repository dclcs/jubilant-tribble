//
//  GTListLoader.h
//  NewsApp
//
//  Created by dcl on 2021/5/15.
//

#import <Foundation/Foundation.h>

@class GTListItem;


NS_ASSUME_NONNULL_BEGIN
typedef void(^GTListLoaderFinishBlock)(BOOL success, NSArray<GTListItem *> *dataArray);

@interface GTListLoader : NSObject
-(void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock;
@end

NS_ASSUME_NONNULL_END
