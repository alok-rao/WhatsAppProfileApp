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
        _profileImage.glassColor = [UIColor grayColor];
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
}

@end
