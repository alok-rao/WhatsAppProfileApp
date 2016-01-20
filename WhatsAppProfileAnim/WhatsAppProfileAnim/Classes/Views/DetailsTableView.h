//
//  DetailsTableView.h
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WABaseInfo.h"

@interface DetailsTableView : UITableView

@property (nonatomic, strong) NSArray <WABaseInfo *> * detailsArray; // WABasicInfo type
@property (nonatomic, weak) id<UIScrollViewDelegate> scrollDelegate;

- (CGFloat)deltaScrollForOffset:(CGFloat)scrollOffset ;

@end
