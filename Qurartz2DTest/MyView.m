//
//  MyView.m
//  Qurartz2DTest
//
//  Created by guolei on 2019/6/24.
//  Copyright © 2019 guolei. All rights reserved.
//

#import "MyView.h"
#import "UIBezierPath+Color.h"
@interface MyView()

@property (nonatomic,assign) CGPoint  startPoint;

@property (nonatomic,assign) CGPoint  endPoint;

@property (nonatomic,strong) UIBezierPath  *path;

@property (nonatomic,strong) NSMutableArray  *paths;

@end

@implementation MyView

- (void)awakeFromNib{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.paths = [NSMutableArray array];
    [self addGestureRecognizer:pan];
    
    self.color = [UIColor lightGrayColor];
    self.lineWidth = 5;
}

- (void)pan:(UIPanGestureRecognizer*)pan{
    
    CGPoint curPoint = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPoint = curPoint;
        self.path = [UIBezierPath bezierPath];
        [self.path moveToPoint:self.startPoint];
        self.path.color = self.color;
        self.path.lineWidth = self.lineWidth;
        [self.paths addObject:self.path];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        self.endPoint = curPoint;
        [self.path addLineToPoint:self.endPoint];
        [self setNeedsDisplay];
    }else if (pan.state == UIGestureRecognizerStateEnded){
    }
    
}

- (void)drawRect:(CGRect)rect {
    for (UIBezierPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage*)path;
            [image drawInRect:rect];
            continue;
        }
        [path.color set];
        [path setLineWidth:path.lineWidth];
        [path stroke];
    }
}

- (void)clear{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
- (void)repeal{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
- (void)earsa{
    self.color = self.backgroundColor;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

@end
