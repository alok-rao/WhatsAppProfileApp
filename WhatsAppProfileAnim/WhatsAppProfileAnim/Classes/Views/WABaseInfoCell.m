//
//  WABaseInfoCell.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "WABaseInfoCell.h"

@implementation WABaseInfoCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

+ (NSString *)cellName {
    return @"";
}

- (void)setBaseInfo:(WABaseInfo *)baseInfo {
    _baseInfo = baseInfo;
}

@end
