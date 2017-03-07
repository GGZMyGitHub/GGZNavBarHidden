//
//  GGZViewController.h
//  GGZNavBarHidden
//
//  Created by apple on 17/3/7.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, GGZHidenControlOptions) {
    
    GGZHidenControlOptionLeft = 0x01,
    GGZHidenControlOptionTitle = 0x01 << 1,
    GGZHidenControlOptionRight = 0x01 << 2,
    
};

@interface GGZViewController : UIViewController

- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(GGZHidenControlOptions)options;


@end
