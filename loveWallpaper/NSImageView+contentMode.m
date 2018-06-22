//
//  NSImageView+contentMode.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "NSImageView+contentMode.h"
#import <objc/runtime.h>
static char *contentModeKey = "contentModeKey";
static char *orginImageKey = "orginImageKey";
@implementation NSImageView (contentMode)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(setImage:);
        SEL swizzledSelector = @selector(pre_setImage:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });

    
}

- (void)setContentMode:(NSViewContentMode)contentMode{
    objc_setAssociatedObject(self, contentModeKey, [NSNumber numberWithInteger:contentMode], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSViewContentMode)contentMode{
    NSNumber *number = objc_getAssociatedObject(self, contentModeKey);
    return [number integerValue];
}

- (void)setOrginImage:(NSImage *)orginImage{
    objc_setAssociatedObject(self, orginImageKey, orginImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSImage *)orginImage{
    return objc_getAssociatedObject(self, orginImageKey);
}

- (void)pre_setImage:(NSImage *)image{
    if (image) {
        switch (self.contentMode) {
            case NSViewContentModeScaleAspectFill:
                {
                    image = [self resizeImage:image size:self.bounds.size];
                }
                break;
                
            default:
                break;
        }
    }
    [self pre_setImage:image];
}

- (NSImage*) resizeImage:(NSImage*)sourceImage size:(NSSize)size{
    if (size.height == 0) {
        return nil;
    }
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage *targetImage = [[NSImage alloc] initWithSize:size];

    NSSize sourceSize = [sourceImage size];

    float ratioH = size.height/ sourceSize.height;
    float ratioW = size.width / sourceSize.width;

    NSRect cropRect = NSZeroRect;
    if (ratioH >= ratioW) {
        cropRect.size.width = floor (size.width / ratioH);
        cropRect.size.height = sourceSize.height;
    } else {
        cropRect.size.width = sourceSize.width;
        cropRect.size.height = floor(size.height / ratioW);
    }

    cropRect.origin.x = floor( (sourceSize.width - cropRect.size.width)/2 );
    cropRect.origin.y = floor( (sourceSize.height - cropRect.size.height)/2 );

    [targetImage lockFocus];

    [sourceImage drawInRect:targetFrame
                   fromRect:cropRect       //portion of source image to draw
                  operation:NSCompositingOperationCopy  //compositing operation
                   fraction:1.0              //alpha (transparency) value
             respectFlipped:YES              //coordinate system
                      hints:@{NSImageHintInterpolation:
                                  [NSNumber numberWithInt:NSImageInterpolationHigh]}];

    [targetImage unlockFocus];

    return targetImage;
}

- (void)update{
//    NSImage *image = [self resizeImage:self.orginImage size:self.bounds.size];
//    [self pre_setImage:image];
}



@end
