//
//  UIImage+PixelData.h
//  single0507
//
//  Created by n on 16/5/12.
//  Copyright © 2016年 summerwu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef struct RGBAPixel {
    char red;
    char green;
    char blue;
    char alpha;
} RGBAPixel;
extern RGBAPixel const RGBAPixelWhite;

// JUN是为了防止命名冲突（JUNE的简写）
typedef NS_ENUM(NSUInteger, JUNChannel) {
    JUNChannelRed,
    JUNChannelGreen,
    JUNChannelBlue,
};

typedef RGBAPixel(^PixelProcessingBlock)(RGBAPixel pixel);
@interface UIImage (PixelData)

/// 每次调用这个方法都会创建一个新的图片
- (UIImage *)imageWithPixelProcessingBlock:(RGBAPixel(^)(RGBAPixel pixel))block;
- (UIImage *)imageWithOnlyOneChannel:(JUNChannel)channel;
- (UIImage *)imageToExtractChannelSecret;

// 题目(可视化-1 )要求绘制很多个圆，这些圆会组成一个答案
+ (UIImage *)imageOfCircle;
+ (UIImage *)imageOfCircleWithPixelCount:(NSUInteger)count;
@end
