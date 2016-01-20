//
//  ProfileImageView.h
//  EffectSample
//
//  Created by Dhanyaraj on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDKBlurredBackgroundDefaultLevel 0.9f
#define kDKBlurredBackgroundDefaultGlassLevel 0.2f
#define kDKBlurredBackgroundDefaultGlassColor [UIColor whiteColor]


@interface ProfileImageView : UIImageView


@property (nonatomic, strong) UIImage *originalImage;
//@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) float initialBlurLevel;
@property (nonatomic, assign) float initialGlassLevel;
@property (nonatomic, assign) BOOL isGlassEffectOn;
@property (nonatomic, strong) UIColor *glassColor;

@property (nonatomic, strong) UIImageView *imageView;

- (void)initialize;
- (void)setBlurLevel:(float)blurLevel;
- (void) changeWithFrame:(CGRect)inFrame;
@end
