//
//  ImageCollectionViewItem.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/20.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "ImageCollectionViewItem.h"
#import "UIImageView+WebCache.h"
#import "ClipView.h"
#import "NSImageView+contentMode.h"
#define RGB(r,g,b) [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
@interface ImageCollectionViewItem ()

@property (nonatomic, strong) NSImageView *coverImageView;
@property (nonatomic, strong) NSTextField *nameLabel;

@property (nonatomic, strong) ClipView *clipView;
@end



@implementation ImageCollectionViewItem
- (void)loadView{
    self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 250, 150)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (instancetype)init{
    return  nil;
}
- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSTrackingArea *trackArea = [[NSTrackingArea alloc] initWithRect:self.view.frame options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow) owner:self userInfo:nil];
        [self.view addTrackingArea:trackArea];
        
        self.view.wantsLayer = true;
        self.view.layer.backgroundColor = [[NSColor redColor] CGColor];
//        [self.view updateTrackingAreas];
        
        self.coverImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
        self.coverImageView.wantsLayer = YES;
        self.coverImageView.contentMode = NSViewContentModeScaleAspectFill;
        self.coverImageView.layer.backgroundColor = [RGB(162, 39, 49) CGColor];
        [self.view addSubview:self.coverImageView];


        self.clipView = [[ClipView alloc] initWithFrame:NSMakeRect(0, 20, 100, 30)];
//        self.clipView.wantsLayer = YES;
//        self.clipView.layer.backgroundColor = [[[NSColor blackColor] colorWithAlphaComponent:0.6] CGColor];
        [self.coverImageView addSubview:self.clipView];
        
        
        self.nameLabel = [[NSTextField alloc] initWithFrame:self.clipView.frame];
        self.nameLabel.frame = NSOffsetRect(self.clipView.frame, 0, -6);
        self.nameLabel.editable = NO;
        self.nameLabel.selectable = NO;
        self.nameLabel.backgroundColor = [NSColor clearColor];
        self.nameLabel.bordered = NO;
        self.nameLabel.textColor = [[NSColor whiteColor] colorWithAlphaComponent:0.9];
        self.nameLabel.font = [NSFont labelFontOfSize:15];
        [self.coverImageView addSubview:self.nameLabel];
       
        NSShadow *shadow = [[NSShadow alloc] init];
        
        [shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.8]];
        [shadow setShadowOffset:NSMakeSize(0, -2)];
        [shadow setShadowBlurRadius:5];
        self.view.wantsLayer = YES;
        [self.view setShadow:shadow];
    }
    return self;
}
- (void)mouseEntered:(NSEvent *)event{
    [[NSCursor pointingHandCursor] set];
}

- (void)mouseExited:(NSEvent *)event{
    [[NSCursor arrowCursor] set];
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
//    http://p15.qhimg.com/bdr/__25/t013f358a6a343059ab.jpg
    
    if (dic[@"name"]) {
        __weak typeof(self) weakSelf = self;
        _nameLabel.stringValue = dic[@"name"];
        NSURL *url = [NSURL URLWithString:@"http://p19.qhimg.com/bdm/250_150_100/t013f358a6a343059ab.jpg"];
        [_coverImageView sd_setImageWithURL:url completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            NSImage *im =[weakSelf resizeImage:image size:weakSelf.view.bounds.size];
            weakSelf.coverImageView.image = im;
        }];
    }else{
        self.nameLabel.hidden = YES;
        self.clipView.hidden =YES;
        __weak typeof(self) weakSelf = self;
        NSString *urlstr = dic[@"url_thumb"];
        NSURL *url = [NSURL URLWithString:urlstr];
        
        
        NSString *thumbUrlStr = [NSString stringWithFormat:@"%@://%@/bdm/250_150_100/%@", url.scheme,url.host,[url pathComponents][1]];
        NSURL * nurl = [NSURL URLWithString:thumbUrlStr];
        [_coverImageView sd_setImageWithURL:nurl completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            NSImage *im =[weakSelf resizeImage:image size:weakSelf.view.bounds.size];
            weakSelf.coverImageView.image = im;
        }];
    }

    
//    self.coverImageView.image = [self resizeImage:self.coverImageView.image size:NSMakeSize(100, 100)];

}
- (NSImage *)resizeImage:(NSImage *)image size:(NSSize)size{
    float w = image.size.width;
    float h = image.size.height;
    float ap = w/h;
    
    float nh = size.height;
    float nw = nh*ap;
    image.size = NSMakeSize(MAX(nw, nh), MIN(nw, nh));
    return image;
}

//- (NSImage*) resizeImage:(NSImage*)sourceImage size:(NSSize)size{
//    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
//    NSImage*  targetImage = [[NSImage alloc] initWithSize:size];
//
//    NSSize sourceSize = [sourceImage size];
//
//    float ratioH = size.height/ sourceSize.height;
//    float ratioW = size.width / sourceSize.width;
//
//    NSRect cropRect = NSZeroRect;
//    if (ratioH >= ratioW) {
//        cropRect.size.width = floor (size.width / ratioH);
//        cropRect.size.height = sourceSize.height;
//    } else {
//        cropRect.size.width = sourceSize.width;
//        cropRect.size.height = floor(size.height / ratioW);
//    }
//
//    cropRect.origin.x = floor( (sourceSize.width - cropRect.size.width)/2 );
//    cropRect.origin.y = floor( (sourceSize.height - cropRect.size.height)/2 );
//
//
//
//    [targetImage lockFocus];
//
//    [sourceImage drawInRect:targetFrame
//                   fromRect:cropRect       //portion of source image to draw
//                  operation:NSCompositingOperationCopy  //compositing operation
//                   fraction:1.0              //alpha (transparency) value
//             respectFlipped:YES              //coordinate system
//                      hints:@{NSImageHintInterpolation:
//                                  [NSNumber numberWithInt:NSImageInterpolationHigh]}];
//
//    [targetImage unlockFocus];
//
//    return targetImage;
//}
@end
