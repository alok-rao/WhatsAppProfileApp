//
//  ResizableProfileView.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "ResizableProfileView.h"
#import "ProfileImageView.h"

@interface ResizableProfileView()

@property (strong, nonatomic) ProfileImageView *profileImage;

@end


@implementation ResizableProfileView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.profileImage = [[ProfileImageView alloc] initWithFrame:self.bounds];
        _profileImage.originalImage = [UIImage imageNamed:@"IMG_0317.jpg"];
        _profileImage.isGlassEffectOn = YES;
        _profileImage.glassColor = [UIColor blackColor];
        _profileImage.imageView = _profileImage;
        
        [self addSubview:self.profileImage];

        
    }
    return self;
}
- (CGFloat)deltaHeightForOffset:(CGFloat)offsetHeight {
    CGRect frame = self.frame;
    CGFloat resultantHeight = 0;
    
    if (offsetHeight > 0) {
        resultantHeight = (self.maximumHeight - (frame.size.height + offsetHeight) >= 0)? offsetHeight:
        self.maximumHeight - frame.size.height;
    } else {
        resultantHeight = (self.minimumHeight < (frame.size.height + offsetHeight))? offsetHeight:
        self.minimumHeight - frame.size.height;
    }
    
    return resultantHeight;
}


- (void) setFrame:(CGRect)frame
{
    // Call the parent class to move the view
    [super setFrame:frame];
    
    // Do your custom code here.
    [self.profileImage changeWithFrame:frame];
    
    CGFloat blurVal = [self getBlurValueForHeight:frame.size.height];
    [self.profileImage setBlurLevel:blurVal];
    
}

- (CGFloat) getBlurValueForHeight:(CGFloat)height {
    CGFloat minHeight = self.minimumHeight;// 100.0;
    CGFloat maxHeight = self.maximumHeight;// 500.0;
    
    CGPoint range = CGPointMake(0, 1);
    CGFloat unit = range.y / (maxHeight - minHeight);
    
//    CGFloat retValue = (height - minHeight) * unit;
    CGFloat retValue = (maxHeight - (height - minHeight)) * unit;

    
    return retValue;
}

@end
