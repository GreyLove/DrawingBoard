//
//  MyView.h
//  Qurartz2DTest
//
//  Created by guolei on 2019/6/24.
//  Copyright © 2019 guolei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView
@property (nonatomic,strong) UIColor  *color;
@property (nonatomic,assign) CGFloat  lineWidth;
@property (nonatomic,strong) UIImage  *image;

- (void)clear;
- (void)repeal;
- (void)earsa;
@end

NS_ASSUME_NONNULL_END
