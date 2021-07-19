//
//  GTVideoPlayer.m
//  NewsApp
//
//  Created by dcl on 2021/6/20.
//
#import <UIKit/UIKit.h>
#import "GTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface GTVideoPlayer()
@property(nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property(nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property(nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;
@end

@implementation GTVideoPlayer
+(GTVideoPlayer *)Player{
    static GTVideoPlayer* player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[GTVideoPlayer alloc] init];
    });
    return player;
}

-(void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView{
    [self _stopPlay];
    NSURL *videourl = [NSURL URLWithString:videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:videourl];
    _videoItem = [AVPlayerItem playerItemWithAsset:asset];
    
    [_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    CMTime duration = _videoItem.duration;
    CGFloat videoDuration = CMTimeGetSeconds(duration);
    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度: %@", @(CMTimeGetSeconds(time)));
    }];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    _playerLayer.frame = attachView.bounds;
    [attachView.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handerPlayerEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    NSLog(@"");
//    [_avPlayer play];

}


-(void) _stopPlay{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    [_playerLayer removeFromSuperlayer];
    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    _videoItem = nil;
    _avPlayer = nil;
}

- (void) _handerPlayerEnd{
   
    
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if(((NSNumber *) [change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay){
            [_avPlayer play];
        }else{
            NSLog(@"");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSLog(@"缓存状态：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
