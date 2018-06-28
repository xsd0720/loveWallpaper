//
//  UITextField.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/28.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "UITextField.h"

@interface UITextField()
@property (nonatomic, strong) NSTextField *textField;
@end
@implementation UITextField
- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        
        self.textField = [[NSTextField alloc] initWithFrame:self.bounds];
        self.textField.backgroundColor = [NSColor clearColor];
        self.textField.bordered = NO;
        [self.textField setTarget:self];
        [self.textField setAction:@selector(abc:)];
//        [[self.textField cell] setUsesSingleLineMode:YES];
        [[self.textField cell] setWraps:NO];
        [[self.textField cell] setScrollable:YES];

        [self addSubview:self.textField];
        self.focusRingType = NSFocusRingTypeNone;
    }
    return self;
}
- (void)abc:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldEnterKey:value:)]) {
        [self.delegate textFieldEnterKey:self value:self.textField.stringValue];
    }
}
- (void)setFont:(NSFont *)font{
    self.textField.font = font;
}
- (void)setFocusRingType:(NSFocusRingType)focusRingType{
    self.textField.focusRingType = focusRingType;
}

- (void)setStringValue:(NSString *)stringValue{
    self.textField.stringValue = stringValue;
}
- (void)setPlaceholder:(NSString *)placeholder{
    self.textField.placeholderString = placeholder;
}
- (void)setLeftView:(NSView *)leftView{
    _leftView = leftView;
    [self addSubview:leftView];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(0, 0)];
    [path lineToPoint:NSMakePoint(dirtyRect.size.width-12, 0)];
    [path lineToPoint:NSMakePoint(dirtyRect.size.width, dirtyRect.size.height)];
    [path lineToPoint:NSMakePoint(12, dirtyRect.size.height)];
    [path closePath];
    [[NSColor whiteColor] set];
    [path fill];
    
    CGFloat fontSize = self.textField.font.boundingRectForFont.size.height;
    NSInteger offset =  floor((NSHeight(self.bounds) - ceilf(fontSize))/2);
    NSRect centeredRect = NSInsetRect(self.bounds, 12, offset);
    centeredRect.origin.x += NSWidth(self.leftView.frame)+5;
    centeredRect.size.width-=NSWidth(self.leftView.frame)+5;
    self.textField.frame = centeredRect;
}

@end
