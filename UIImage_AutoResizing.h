//
//  UIImage_AutoResizing.h
//  AutoResizingImages
//
//  Created by Zachry Thayer on 12/4/11.
//  Copyright (c) 2011 Zachry Thayer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIImage_AutoResizingKeyColor 0xffff00ff
#define UIImage_AutoResizingMarkerColor 0xff000000

@interface UIImage (AutoResizing)

+ (UIImage*)autoResizingImageNamed:(NSString*)imageName;

@end
