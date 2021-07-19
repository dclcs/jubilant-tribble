//
//  GTVideoCoverView.m
//  NewsApp
//
//  Created by dcl on 2021/6/17.
//

#import "GTVideoCoverView.h"
#import <AVFoundation/AVFoundation.h>
#import "GTVideoPlayer.h"
#import "GTVideoToolBar.h"
@interface GTVideoCoverView()
@property(nonatomic, strong, readwrite) UIImageView *coverView;
@property(nonatomic, strong, readwrite) UIImageView *playButton;
@property(nonatomic, copy, readwrite) NSString *videoUrl;
@property(nonatomic, strong, readwrite)GTVideoToolBar *toolbar;
@end

@implementation GTVideoCoverView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - GTVideoToolBarHeight)];
            _coverView;
        })];
        [self addSubview:({
            _toolbar = [[GTVideoToolBar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolBarHeight)];
            _toolbar;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - GTVideoToolBarHeight - 50) / 2, 50, 50)];
            _playButton;
        })];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
    [self addGestureRecognizer:tapGesture];
    
    
    return self;
}

-(void)dealloc{
   

}

#pragma mark - publlic

-(void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl{
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/video_played@3x.png"];
    _videoUrl = videoUrl;
    [_toolbar layoutWithModel:nil];
}
#pragma mark - private

-(void)_tapToPlay{
    [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}

@end
