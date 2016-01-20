//
//  DetailsTableView.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "DetailsTableView.h"
#import "WAStatusInfoCell.h"

@interface DetailsTableView () <UITableViewDataSource, UITableViewDelegate>


@end

@implementation DetailsTableView

# pragma mark - Cell Setup

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerNib:[UINib nibWithNibName:@"WAStatusInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[WAStatusInfoCell cellName]];
    }

    return self;
}

- (void)setDetailsArray:(NSArray<WABaseInfo *> *)detailsArray {
    _detailsArray = detailsArray;
    
    [self reloadData];
}

# pragma mark - UITableViewControllerDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WABaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellNameAtIndexPath:indexPath] forIndexPath:indexPath];
    [self setUpCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static WABaseInfoCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [self dequeueReusableCellWithIdentifier:[self cellNameAtIndexPath:indexPath]];
    });
    
    [self setUpCell:cell atIndexPath:indexPath];
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (NSString*) cellNameAtIndexPath: (NSIndexPath*)indexPath {
    WABaseCellType cellType = self.detailsArray[indexPath.row].cellType;
    NSString* cellName = @"";
    
    switch (cellType) {
        case eWABaseCellTypeStatus:
            cellName = [WAStatusInfoCell cellName];
            break;
            
        default:
            break;
    }
    
    return cellName;
}

- (void)setUpCell:(WABaseInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.baseInfo = [self.detailsArray objectAtIndex:indexPath.row];
}

#pragma mark - UIScrollView Delegate methods

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.scrollDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([self.scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollDelegate scrollViewDidScroll:scrollView];
    }
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.scrollDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.scrollDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollDelegate scrollViewWillBeginDragging:scrollView];
    }
}

#pragma mark - Calculation

- (CGFloat)deltaScrollForOffset:(CGFloat)scrollOffset {
    CGPoint offset = (CGPoint){self.contentOffset.x + self.frame.size.width, self.contentOffset.y + self.frame.size.height};
    CGFloat resultantScrollOffset = 0;
    
    scrollOffset = - scrollOffset;
    
    if (scrollOffset > 0) {
        resultantScrollOffset = (self.contentSize.height > offset.y + scrollOffset)? scrollOffset:
        self.contentSize.height - offset.y;
    } else {
        resultantScrollOffset = (offset.y + scrollOffset > 0)? scrollOffset:
        0 - self.contentOffset.y;
    }
    
    return resultantScrollOffset;
}



@end
