//
//  GTVideoCoverView.h
//  NewsApp
//
//  Created by dcl on 2021/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoCoverView : UICollectionViewCell
-(void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;
@end

NS_ASSUME_NONNULL_END
