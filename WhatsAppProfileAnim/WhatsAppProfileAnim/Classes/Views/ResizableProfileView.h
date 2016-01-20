//
//  ResizableProfileView.h
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResizableProfileView : UIView

@property (nonatomic, assign) CGFloat minimumHeight;
@property (nonatomic, assign) CGFloat maximumHeight;

- (CGFloat) deltaHeightForOffset:(CGFloat)offsetHeight;

@end
