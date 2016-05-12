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

typedef RGBAPixel(^PixelProcessingBlock)(RGBAPixel pixel);
@interface UIImage (PixelData)
- (UIImage *)imageWithPixelProcessingBlock:(RGBAPixel(^)(RGBAPixel pixel))block;
@end
