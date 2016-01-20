//
//  WABaseInfo.h
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WABaseCellType) {
    eWABaseCellTypeStatus,
    eWABaseCellTypePhone
};

@interface WABaseInfo : NSObject

@property (nonatomic, assign) WABaseCellType cellType;

@end

@interface WAStatusInfo : WABaseInfo

@property (nonatomic, copy) NSString* statusMessage;
@property (nonatomic, copy) NSDate* statusMessagePostedDate;

@end

@interface WAPhoneInfo : WABaseInfo

@property (nonatomic, copy) NSString* phoneNumber;

@end