//
//  ZMImageView.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMImageView.h"

@interface ZMImageView ()

@property (nonatomic, strong) UIVisualEffectView        *backVisual;
@property (nonatomic, strong) CAShapeLayer              *progressLayer;
@property (nonatomic, strong) UIActivityIndicatorView   *indicator;

@end

@implementation ZMImageView
{
    UIImage *_image;
}
- (instancetype)init{
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

//因为高点会把placeholder的照片设为高亮照片，暂时这样处理，以后可以重写sethightlight方法判断
-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:NO];
}

- (void)setImage:(UIImage *)image {
    if (_turnOffSetLayer) {
        [super setImage:image];
    }else{
        _image = image;
        self.layer.contents = (id)image.CGImage;
    }
}

- (UIImage *)image {
    if (_turnOffSetLayer) {
        return [super image];
    }else{
        id content = self.layer.contents;
        if (content != (id)_image.CGImage) {
            CGImageRef ref = (__bridge CGImageRef)(content);
            if (ref && CFGetTypeID(ref) == CGImageGetTypeID()) {
                _image = [UIImage imageWithCGImage:ref scale:self.layer.contentsScale orientation:UIImageOrientationUp];
            } else {
                _image = nil;
            }
        }
        return _image;
    }
}

- (void)setProgressAnimationStyle:(BOOL)isProgressLayer{
    if (isProgressLayer) {
        CGFloat lineHeight = 4;
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.size = CGSizeMake(self.width, lineHeight);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, _progressLayer.height / 2)];
        [path addLineToPoint:CGPointMake(self.width, _progressLayer.height / 2)];
        _progressLayer.lineWidth = lineHeight;
        _progressLayer.path = path.CGPath;
        _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
        _progressLayer.lineCap = kCALineCapButt;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        [self.layer addSublayer:_progressLayer];
    }else{
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.center = CGPointMake(self.width / 2, self.height / 2);
        //        _indicator.hidden = YES;
        [self addSubview:_indicator];
    }
}

- (void)setAnimationLoadingImage:(NSURL *)url placeholder:(UIImage *)placeholder{
    if (_indicator) {
        _indicator.hidden = NO;
        [_indicator startAnimating];
    }else if (self.progressLayer) {
        [CATransaction begin];
        [CATransaction setDisableActions: YES];
        self.progressLayer.hidden = YES;
        self.progressLayer.strokeEnd = 0;
        [CATransaction commit];
    }
    WEAKSELF;
    
    [self setImageWithURL:url placeholder:placeholder options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (weakSelf.progressLayer) {
            if (expectedSize > 0 && receivedSize > 0) {
                CGFloat progress = (CGFloat)receivedSize / expectedSize;
                progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
                if (weakSelf.progressLayer.hidden) weakSelf.progressLayer.hidden = NO;
                weakSelf.progressLayer.strokeEnd = progress;
            }
        }
        
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (stage == YYWebImageStageFinished) {
            if (weakSelf.progressLayer) {
                weakSelf.progressLayer.hidden = YES;
            }
            if (weakSelf.indicator) {
                [weakSelf.indicator stopAnimating];
                weakSelf.indicator.hidden = YES;
            }
        }
    }];
}

#pragma mark - 设置模糊效果
- (void)setBlurImageView{
    self.backVisual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.backVisual.frame = self.bounds;
    self.backVisual.alpha = 1.0;
    [self addSubview:self.backVisual];
}

@end


@interface ZMMaskImageView()

@end

@implementation ZMMaskImageView

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _maskView;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setIsShowMask:(BOOL)isShowMask{
    self.maskView.hidden = !isShowMask;
}

@end

