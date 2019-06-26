//
//  UIBezierPath+Color.m
//  Qurartz2DTest
//
//  Created by guolei on 2019/6/26.
//  Copyright © 2019 guolei. All rights reserved.
//

#import "UIBezierPath+Color.h"
#import <objc/message.h>
@implementation UIBezierPath (Color)

- (void)setColor:(UIColor *)color{
    objc_setAssociatedObject(self, "color", color, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)color{
    return  objc_getAssociatedObject(self, "color");
}

@end
