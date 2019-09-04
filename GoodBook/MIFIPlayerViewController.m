//
//  MIFIPlayerViewController.m
//  GoodBook
//
//  Created by liuyang on 2019/9/2.
//  Copyright © 2019 liuyang. All rights reserved.
//

#import "MIFIPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MIFIPlayerViewController ()

@property (nonatomic, strong) AVPlayer *avPlayer; //播放器
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;

@end

@implementation MIFIPlayerViewController

- (instancetype)initWithUrls:(NSArray *)urls currentIndex:(NSInteger)currentIndex {
    if (self = [super init]) {
        self.urls = urls;
        self.currentIndex = currentIndex;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view.layer addSublayer:self.avPlayerLayer];
    
    [self.avPlayer play];
}

- (NSURL *)getCurrentUrl {
    NSURL *url;
    if (self.urls && self.currentIndex < self.urls.count) {
        url = [NSURL URLWithString:self.urls[self.currentIndex]];
    }
    return url;
}

#pragma mark - lazyload
- (AVPlayer *)avPlayer {
    if (!_avPlayer) {
        AVPlayerItem *currentPlayerItem = [[AVPlayerItem alloc] initWithURL:[self getCurrentUrl]];

        _avPlayer = [[AVPlayer alloc] initWithPlayerItem:currentPlayerItem];
        [_avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [_avPlayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _avPlayer;
}

- (AVPlayerLayer *)avPlayerLayer {
    if (!_avPlayerLayer) {
        _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        _avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        _avPlayerLayer.frame = self.view.bounds;
    }
    return _avPlayerLayer;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *avPlayerItem = (AVPlayerItem *)object;
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];

        switch (status) {
            case AVPlayerStatusReadyToPlay: {
                NSLog(@"--success");
//                CMTime duration = avPlayerItem.duration;

                [self.avPlayer play];

                break;
            }
            case AVPlayerStatusFailed: {
                NSLog(@"--failed");
            }
            case AVPlayerStatusUnknown: {
                NSLog(@"--unknown problem");
            }
            default:
            break;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
