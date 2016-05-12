//
//  UIImage+PixelData.m
//  single0507
//
//  Created by n on 16/5/12.
//  Copyright © 2016年 summerwu. All rights reserved.
//

#import "UIImage+PixelData.h"

@implementation UIImage (PixelData)
- (UIImage *)imageWithPixelProcessingBlock:(RGBAPixel(^)(RGBAPixel pixel))block{
    // load image
    CGImageRef imageRef = self.CGImage;
    NSData *data        = (NSData *)CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(imageRef)));
    char *pixels        = (char *)[data bytes];

    // this is where you manipulate the individual pixels
    // assumes a 4 byte pixel consisting of rgb and alpha
    // for PNGs without transparency use i+=3 and remove int a
    for(int i = 0; i < [data length]; i += 4)
    {
        int r = i;
        int g = i+1;
        int b = i+2;
        int a = i+3;
        RGBAPixel currentPx = {0,0,0,0};
        currentPx.red   = pixels[r];
        currentPx.green = pixels[g];
        currentPx.blue  = pixels[b];
        currentPx.alpha = pixels[a];
        currentPx = block(currentPx);//让block对每一个像素进行处理

        pixels[r]   = currentPx.red; // eg. remove red
        pixels[g]   = currentPx.green;
        pixels[b]   = currentPx.blue;
        pixels[a]   = currentPx.alpha;
    }

    // create a new image from the modified pixel data
    size_t width                    = CGImageGetWidth(imageRef);
    size_t height                   = CGImageGetHeight(imageRef);
    size_t bitsPerComponent         = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel             = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow              = CGImageGetBytesPerRow(imageRef);

    CGColorSpaceRef colorspace      = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo         = CGImageGetBitmapInfo(imageRef);
    CGDataProviderRef provider      = CGDataProviderCreateWithData(NULL, pixels, [data length], NULL);

    CGImageRef newImageRef = CGImageCreate (
                                            width,
                                            height,
                                            bitsPerComponent,
                                            bitsPerPixel,
                                            bytesPerRow,
                                            colorspace,
                                            bitmapInfo,
                                            provider,
                                            NULL,
                                            false,
                                            kCGRenderingIntentDefault
                                            );
    // the modified image
    UIImage *newImage   = [UIImage imageWithCGImage:newImageRef];

    // cleanup
    CGColorSpaceRelease(colorspace);
    CGDataProviderRelease(provider);
    CGImageRelease(newImageRef);
    return newImage;

}


@end
