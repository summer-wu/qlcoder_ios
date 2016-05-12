//
//  ViewController.m
//  single0507
//
//  Created by n on 16/5/7.
//  Copyright © 2016年 summerwu. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+PixelData.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *greenBtn;
@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iv.backgroundColor = [UIColor blueColor];
    self.iv.image = [self originalImage];
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    [_redBtn addTarget:self action:@selector(redButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_greenBtn addTarget:self action:@selector(greenButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_blueBtn addTarget:self action:@selector(blueButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btn0 addTarget:self action:@selector(btn0Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)redButtonDidClick:(id)sender{
    UIImage *i = [self originalImage];
    i = [i imageWithOnlyOneChannel: JUNChannelRed];
    self.iv.image = i;
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
    UIImage *i = [self originalImage];
    i = [i imageToExtractChannelSecret];
    self.iv.image = i;
}

- (UIImage *)originalImage{
    UIImage *i = [UIImage imageNamed:@"lenna"];
    return i;
}

#pragma mark - getter

@end
