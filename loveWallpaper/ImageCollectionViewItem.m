//
//  ImageCollectionViewItem.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/20.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "ImageCollectionViewItem.h"
@interface ImageCollectionViewItem ()
@property (nonatomic, strong) NSImageView *coverImageView;
@end

@implementation ImageCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

}
- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.coverImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.coverImageView];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    NSImage *im = [[NSImage alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://p19.qhimg.com/bdm/1600_900_85/t01ae1f4579bf9e95fe.jpg"]];
    
    
    im =[self resizeImage:self.coverImageView.image size:NSMakeSize(100, 100)];
    self.coverImageView.image = im;
//    self.coverImageView.image = [self resizeImage:self.coverImageView.image size:NSMakeSize(100, 100)];

}

- (NSImage*) resizeImage:(NSImage*)sourceImage size:(NSSize)size{
    
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage*  targetImage = [[NSImage alloc] initWithSize:size];
    
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
                  operation:NSCompositeCopy  //compositing operation
                   fraction:1.0              //alpha (transparency) value
             respectFlipped:YES              //coordinate system
                      hints:@{NSImageHintInterpolation:
                                  [NSNumber numberWithInt:NSImageInterpolationLow]}];
    
    [targetImage unlockFocus];
    
    return targetImage;
}

@end
