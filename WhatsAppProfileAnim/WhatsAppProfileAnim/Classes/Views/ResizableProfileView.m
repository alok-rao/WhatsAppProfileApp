//
//  ResizableProfileView.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "ResizableProfileView.h"

@implementation ResizableProfileView

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

@end
