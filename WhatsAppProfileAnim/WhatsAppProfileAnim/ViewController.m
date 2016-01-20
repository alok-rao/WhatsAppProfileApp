//
//  ViewController.m
//  WhatsAppProfileAnim
//
//  Created by Alok Rao on 20/01/16.
//  Copyright © 2016 Paytm. All rights reserved.
//

#import "ViewController.h"
#import "DetailsTableView.h"
#import "ResizableProfileView.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet DetailsTableView *detailsTableView;
@property (weak, nonatomic) IBOutlet ResizableProfileView *resizeProfileView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self createTapGesture];
    [self defaultPlacement];
    [self createTableModel];
}
     
- (void) createTapGesture {
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void) defaultPlacement {
    
    // Resize ProfileView placement
    
    self.resizeProfileView.backgroundColor = [UIColor redColor];
    self.resizeProfileView.frame = CGRectMake(0,
                                              0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) * 0.5f);
    self.resizeProfileView.minimumHeight = 50;
    self.resizeProfileView.maximumHeight = CGRectGetHeight(self.view.frame) * 0.6f;
    self.resizeProfileView.userInteractionEnabled = NO;
    
    // TableView Placement
    
    self.detailsTableView.scrollDelegate = self;
    self.detailsTableView.frame = CGRectMake(0,
                                             CGRectGetMaxY(self.resizeProfileView.frame),
                                             CGRectGetWidth(self.view.frame),
                                             CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.resizeProfileView.frame));
    self.detailsTableView.bounces = NO;
    self.detailsTableView.userInteractionEnabled = NO;
    
}

- (void) createTableModel {
    
    NSMutableArray* details = [NSMutableArray array];
    
    {
        WAStatusInfo* statusInfo = [[WAStatusInfo alloc]init];
        statusInfo.statusMessage = [self message];
        [details addObject:statusInfo];
    }
    
    {
        WAStatusInfo* statusInfo = [[WAStatusInfo alloc]init];
        statusInfo.statusMessage = [self message];
        [details addObject:statusInfo];
    }
    
    {
        WAStatusInfo* statusInfo = [[WAStatusInfo alloc]init];
        statusInfo.statusMessage = [self message];
        [details addObject:statusInfo];
    }
    
    self.detailsTableView.detailsArray = details;
    
}

- (NSString*) message {
    return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
}

#pragma mark - UIScrollView Delegate methods

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

#pragma mark - Pan On View 

- (void) panOnView:(UIPanGestureRecognizer*)gesture {
    
    static CGPoint lastLocation;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            lastLocation = [gesture locationInView:self.view];
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint currentLocation = [gesture locationInView:self.view];
            CGFloat heightDelta = currentLocation.y - lastLocation.y;
            
            [self updateWithOffset:heightDelta];
            
            lastLocation = currentLocation;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
            break;
            
            
        default:
            break;
    }
}

- (void) updateViewFramesWithOffset:(CGFloat)calculatedOffset {
    self.resizeProfileView.frame = CGRectMake(0, 0, CGRectGetWidth(self.resizeProfileView.frame), CGRectGetHeight(self.resizeProfileView.frame) + calculatedOffset);
    self.detailsTableView.frame = CGRectMake(0, CGRectGetMaxY(self.resizeProfileView.frame), CGRectGetWidth(self.detailsTableView.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.resizeProfileView.frame));
}

- (void) updateWithOffset:(CGFloat)draggedOffset  {
    
    BOOL hasToScroll = NO;
    
    if (CGRectGetHeight(self.resizeProfileView.frame) == self.resizeProfileView.minimumHeight && (self.detailsTableView.contentOffset.y >= 0)) {
        hasToScroll = YES;
    }
    
    CGFloat calculatedDelta = [self.resizeProfileView deltaHeightForOffset:draggedOffset];
    
    if (hasToScroll || (calculatedDelta == 0 && draggedOffset < 0 && self.detailsTableView.contentOffset.y >= 0)) {
        [self updateScroll:draggedOffset];
    } else {
        [self updateViewFramesWithOffset:calculatedDelta];
    }
}

- (void) updateScroll:(CGFloat)draggedOffset {
    
    if (draggedOffset == 0) {
        return;
    }
    
    CGFloat offset = [self.detailsTableView deltaScrollForOffset:draggedOffset];
    
    self.detailsTableView.contentOffset = CGPointMake(0, self.detailsTableView.contentOffset.y + offset);
}

@end
