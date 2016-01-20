//
//  WAStatusInfoCell.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "WAStatusInfoCell.h"

@interface WAStatusInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;

@end

@implementation WAStatusInfoCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStatusInfo:(WAStatusInfo *)statusInfo {
    self.statusMessage.text = statusInfo.statusMessage;
}

+ (NSString *)cellName {
    return @"Status";
}

- (void)setBaseInfo:(WABaseInfo *)baseInfo {
    super.baseInfo = baseInfo;
    
    CGFloat width = CGRectGetWidth(self.frame) - CGRectGetMinX(self.statusMessage.frame) * 2.0f;
    self.statusMessage.preferredMaxLayoutWidth = width;
    
    if ([baseInfo isKindOfClass:[WAStatusInfo class]]) {
        self.statusMessage.text = ((WAStatusInfo*)baseInfo).statusMessage;
    }
}

@end
