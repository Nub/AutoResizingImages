//
//  UIImage_AutoResizing.m
//  AutoResizingImages
//
//  Created by Zachry Thayer on 12/4/11.
//  Copyright (c) 2011 Zachry Thayer. All rights reserved.
//

#import "UIImage_AutoResizing.h"

unsigned int colorFromDataAtPoint(unsigned int* data, unsigned int dataStride,CGPoint point);
unsigned int colorFromDataAtPoint(unsigned int* data, unsigned int dataStride,CGPoint point)
{
    unsigned int offset = (dataStride * point.y) + point.x;
    return data[offset];
}

@implementation UIImage (AutoResizing)

+ (UIImage*)autoResizingImageNamed:(NSString*)imageName{
    
    UIImage *original = [UIImage imageNamed:imageName];
    UIImage *returnImage = original;
        
    CGImageRef imageRef = [original CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned int *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast |
                                                 kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    // Snag the first pixel color
    unsigned int firstPixel = colorFromDataAtPoint(rawData, width, CGPointMake(0, 0));


    // Key color is found run logic this is a scaling image
    if (firstPixel == UIImage_AutoResizingKeyColor) {

        // First rerender the image to remove extra width and height
        UIGraphicsBeginImageContext(CGSizeMake(width - 1, height - 1));
        
        [original drawInRect:CGRectMake(-1, -1, width, height)];
        returnImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        original = nil;
        //if you don't use ARC
        //[original release];
         
        // Second Determine the UIEdgeInsets

        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        
        for (int x = 0; x < width; x ++) {
            
            unsigned int color = colorFromDataAtPoint(rawData, width, CGPointMake(x, 0));
            
            if (color == 0xff000000) {//first cap found
                
                if (edgeInsets.left == 0) {
                    
                    edgeInsets.left = x;
                    
                }
                else
                {
                    
                    edgeInsets.right = width - x;
                    
                }
                
            }
            
        }
        
        for (int y = 0; y < height; y ++) {
            
            unsigned int color = colorFromDataAtPoint(rawData, width, CGPointMake(0,y));
            
            if (color == 0xff000000) {//first cap found
                
                if (edgeInsets.top == 0) {
                    
                    edgeInsets.top = y;
                    
                }
                else
                {
                    
                    edgeInsets.bottom = height - y;
                    
                }
                
            }
            
        }
        
        returnImage = [returnImage resizableImageWithCapInsets:edgeInsets];
         
    }


    // Cleanup
    free(rawData);

    return returnImage;
}

@end
