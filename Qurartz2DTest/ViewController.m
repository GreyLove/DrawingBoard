//
//  ViewController.m
//  Qurartz2DTest
//
//  Created by guolei on 2019/6/24.
//  Copyright © 2019 guolei. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *photo;
@property (weak, nonatomic) IBOutlet UIButton *earsa;
@property (weak, nonatomic) IBOutlet UIButton *repeal;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet MyView *drawView;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)blueClick:(UIButton*)sender {
    self.drawView.color = sender.backgroundColor;
}
- (IBAction)grenClick:(UIButton*)sender {
    self.drawView.color = sender.backgroundColor;

}
- (IBAction)yellowClick:(UIButton*)sender {
    self.drawView.color = sender.backgroundColor;

}
- (IBAction)clearClick:(id)sender {
    [self.drawView clear];
}
- (IBAction)repeal:(id)sender {
    [self.drawView repeal];
}
- (IBAction)earsaClick:(id)sender {
    [self.drawView earsa];
}
- (IBAction)photoClick:(id)sender {
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickVC.delegate = self;
    [self presentViewController:pickVC animated:YES completion:nil];
}
- (IBAction)saveClick:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, YES, 0);
    
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info;
{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    UIView *bgView = [[UIView alloc] initWithFrame: self.drawView.frame];
    [self.view addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:bgView.bounds];
    imageView.userInteractionEnabled = YES;
    [bgView addSubview:imageView];

    imageView.image = image;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    [imageView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinClick:)];
    [imageView addGestureRecognizer:pin];
    
    UILongPressGestureRecognizer *lo = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
    [imageView addGestureRecognizer:lo];
    
//    self.drawView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)panClick:(UIPanGestureRecognizer*)pan{
    CGPoint p = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, p.x, p.y);
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)pinClick:(UIPinchGestureRecognizer*)pin{
    pin.view.transform = CGAffineTransformScale(pin.view.transform, pin.scale, pin.scale);
    [pin setScale:1];
}

- (void)longClick:(UILongPressGestureRecognizer*)lo{
    if (lo.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            lo.view.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
               lo.view.alpha = 1;
            } completion:^(BOOL finished) {
                UIGraphicsBeginImageContextWithOptions(lo.view.superview.frame.size, NO, 0);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [lo.view.superview.layer renderInContext:ctx];
                
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                self.drawView.image = image;
                
                [lo.view.superview removeFromSuperview];
            }];
        }];
    }
}

- (IBAction)change:(UISlider*)sender {
    self.drawView.lineWidth = 10*sender.value;
}
@end
