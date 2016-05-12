//
//  ViewController.m
//  single0507
//
//  Created by n on 16/5/7.
//  Copyright © 2016年 summerwu. All rights reserved.
//

#import "ViewController.h"
#import "JUNImageHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *greenBtn;
@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, readonly) JUNImageHelper *helper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iv.backgroundColor = [UIColor blueColor];
    self.iv.image = [self originalImage];
    self.iv.contentMode = UIViewContentModeScaleAspectFit;
    [_redBtn addTarget:self action:@selector(redButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)redButtonDidClick:(id)sender{
    UIImage *i = [self.helper onlyRedChannelFromImage: [self originalImage]];
    self.iv.image = i;
}

- (UIImage *)originalImage{
    UIImage *i = [UIImage imageNamed:@"lenna"];
    return i;
}

#pragma mark - getter
- (JUNImageHelper *)helper{
    return [JUNImageHelper sharedInstance];
}

@end
