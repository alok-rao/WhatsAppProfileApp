//
//  WABaseInfoCell.h
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WABaseInfo.h"

@interface WABaseInfoCell : UITableViewCell

+ (NSString*) cellName;

@property (nonatomic, strong) WABaseInfo* baseInfo;

@end
