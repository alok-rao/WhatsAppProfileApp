//
//  ProfileImageView.m
//  EffectSample
//
//  Created by Dhanyaraj on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "ProfileImageView.h"
#import <Accelerate/Accelerate.h>

@interface ProfileImageView()
{
    
}

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *backgroundGlassView;


@end


@implementation ProfileImageView

@synthesize originalImage = _originalImage;
@synthesize backgroundImageView = _backgroundImageView;
//@synthesize scrollView = _scrollView;
@synthesize initialBlurLevel = _initialBlurLevel;
@synthesize backgroundGlassView = _backgroundGlassView;
@synthesize initialGlassLevel = _initialGlassLevel;
@synthesize isGlassEffectOn = _isGlassEffectOn;
@synthesize glassColor = _glassColor;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    // Initialization code
    
    _initialBlurLevel = kDKBlurredBackgroundDefaultLevel;
    _initialGlassLevel = kDKBlurredBackgroundDefaultGlassLevel;
    _glassColor = kDKBlurredBackgroundDefaultGlassColor;
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame: self.bounds];
    
    _backgroundImageView.alpha = 0.0;
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    
    _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self addSubview: _backgroundImageView];
    
    _backgroundGlassView = [[UIView alloc] initWithFrame: self.bounds];
    
    _backgroundGlassView.alpha = 0.0;
    _backgroundGlassView.backgroundColor = kDKBlurredBackgroundDefaultGlassColor;
    
    _backgroundGlassView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self addSubview: _backgroundGlassView];

}

- (void)setGlassColor:(UIColor *)glassColor {
    _glassColor = glassColor;
    _backgroundGlassView.backgroundColor = glassColor;
}


- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur
                   withRadius:(CGFloat)blurRadius {
    if ((blurRadius <= 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    
    int boxSize = (int)(blurRadius * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef rawImage = imageToBlur.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(rawImage);
    inBuffer.height = CGImageGetHeight(rawImage);
    inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(rawImage);
    outBuffer.height = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(imageToBlur.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (void)setOriginalImage:(UIImage *)originalImage {
    _originalImage = originalImage;
    
    self.image = originalImage;
    
    dispatch_queue_t queue = dispatch_queue_create("Blur queue", NULL);
    
    dispatch_async(queue, ^ {
        
        UIImage *blurredImage = [self applyBlurOnImage: self.originalImage withRadius: self.initialBlurLevel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.backgroundImageView.alpha = 0.0;
            self.backgroundImageView.image = blurredImage;
        });
    });
    
}

- (void)setBlurLevel:(float)blurLevel {
    self.backgroundImageView.alpha = blurLevel;
    
    if (self.isGlassEffectOn) {
        self.backgroundGlassView.alpha = MAX(0.0, MIN(self.backgroundImageView.alpha - self.initialGlassLevel, self.initialGlassLevel));
    }
}

- (void)resizeImageWithFrame:(CGRect)theFrame
{
    CGRect imageViewFrame = [[self imageView] frame];
    
    imageViewFrame.size.width = floorf(theFrame.size.width);
    imageViewFrame.size.height = floorf(theFrame.size.height);
    
    if (CGRectEqualToRect([[self imageView] frame], imageViewFrame) == NO) {
        [[self imageView] setFrame:imageViewFrame];
    }
    
//    [self setBlurLevel:0.0f];

}

- (void) changeWithFrame:(CGRect)inFrame
{
    [self resizeImageWithFrame:inFrame];
    
//    CGRect imageViewFrame = [[self imageView] frame];
//    
//    imageViewFrame.size.width = floorf([sender value]);
//    imageViewFrame.size.height = floorf([sender value]);
//    
//    if (CGRectEqualToRect([[self imageView] frame], imageViewFrame) == NO) {
//        [[self imageView] setFrame:imageViewFrame];
//    }

    
}







@end
