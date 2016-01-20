//
//  WABaseInfo.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "WABaseInfo.h"

@implementation WABaseInfo

@end

@implementation WAPhoneInfo

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.cellType = eWABaseCellTypePhone;
    }
    
    return self;
}

@end

@implementation WAStatusInfo

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.cellType = eWABaseCellTypeStatus;
    }
    
    return self;
}

@end