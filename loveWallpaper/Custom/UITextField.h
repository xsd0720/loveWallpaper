//
//  UITextField.h
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/28.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UITextField;

@protocol UITextFieldDelegate <NSObject>
- (void)textFieldEnterKey:(UITextField *)textFiled value:(NSString *)value;
@end

@interface UITextField : NSControl
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSView *leftView;
@property (nonatomic, assign) id<UITextFieldDelegate> delegate;
@end
