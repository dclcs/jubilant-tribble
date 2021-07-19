//
//  GTVideoPlayer.h
//  NewsApp
//
//  Created by dcl on 2021/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoPlayer : NSObject

+(GTVideoPlayer *)Player;

-(void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;
@end

NS_ASSUME_NONNULL_END
