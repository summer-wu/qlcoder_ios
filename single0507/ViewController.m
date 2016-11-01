//
//  ViewController.m
//  single0507
//
//  Created by n on 16/5/7.
//  Copyright © 2016年 summerwu. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+PixelData.h"
#import "NSData+PNGChunks.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *greenBtn;
@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *originalBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"NSTemporaryDirectory %@",NSTemporaryDirectory());
    NSLog(@"NSUSer %@",NSUserName());
    NSError *e;
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/tmp" error:&e];
    NSLog(@"%@",contents);

    self.iv.backgroundColor = [UIColor blueColor];
    self.iv.maskView = [self maskView];
    self.iv.image = [self originalImage];
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    [_redBtn addTarget:self action:@selector(redButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_greenBtn addTarget:self action:@selector(greenButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_blueBtn addTarget:self action:@selector(blueButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btn0 addTarget:self action:@selector(btn0Click:) forControlEvents:UIControlEventTouchUpInside];
    [_originalBtn addTarget:self action:@selector(orgDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIImageView *)maskView{
    CGRect frame = CGRectMake(20, 50, 90, 90);
    UIImageView *v = [[UIImageView alloc]initWithFrame:frame];
    v.image = [UIImage imageNamed:@"Ship.png"];
    return v;
}

- (void)redButtonDidClick:(id)sender{
//    UIImage *i = [self originalImage];
//    i = [i imageWithOnlyOneChannel: JUNChannelRed];
//    self.iv.image = i;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tree" ofType:@"png"];
    NSData *treeImage = [NSData dataWithContentsOfFile:filePath];
    [treeImage printPNGChunks];

}

- (void)greenButtonDidClick:(id)sender{
    UIImage *i = [self originalImage];
    i = [i imageWithOnlyOneChannel: JUNChannelGreen];
    self.iv.image = i;
}

- (void)blueButtonDidClick:(id)sender{
    UIImage *i = [self originalImage];
    i = [i imageWithOnlyOneChannel: JUNChannelBlue];
    self.iv.image = i;
}

- (void)btn0Click:(id)sender{
//    i = [i imageToExtractChannelSecret];
    for (NSInteger i=0; i<9999; i+=10) {
        NSLog(@"%ld",i);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*i/10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"btn0Click %ld",i);
            UIImage *img = [UIImage imageOfCircleWithPixelCount:i];
            self.iv.image = img;
        });
    }

}

- (void)orgDidClick:(id)sender{
    UIImage *i = [self originalImage];
    self.iv.image = i;
}

- (UIImage *)originalImage{
    UIImage *i = [UIImage imageNamed:@"tree"];//tmall.jpg lenna
    return i;
}

#pragma mark - getter

@end
