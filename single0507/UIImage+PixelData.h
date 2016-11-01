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


+(UIImage *)imageOfCircle;
+ (UIImage *)imageOfCircleWithPixelCount:(NSUInteger)count;
@end
