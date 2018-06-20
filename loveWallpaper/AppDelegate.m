//
//  AppDelegate.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/19.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) NSStatusItem *demoItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

    NSUInteger style =  NSWindowStyleMaskTitled | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable | NSWindowStyleMaskClosable;
    float w = [[NSScreen mainScreen] frame].size.width/1.2;
    float h = [[NSScreen mainScreen] frame].size.height/1.2;
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, w, h) styleMask:style backing:NSBackingStoreBuffered defer:YES];

    self.window.titlebarAppearsTransparent = false;
    self.window.titleVisibility = NSWindowTitleHidden;

    [self.window makeKeyAndOrderFront:nil];
    [self.window center];
    self.homeVC = [[HomeViewController alloc] init];
    [self.window setContentViewController:self.homeVC];

    [self configStatusBar];
}

- (void)configStatusBar{
    self.demoItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    // 设置NSStatusItem 的图片
    NSImage *image = [NSImage imageNamed:@"StatusItem_Icon_20x20_"];
    [self.demoItem setImage: image];
    
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"BarButton_Delete_32x32_"];
    [menu setMinimumWidth:200];
    self.demoItem.menu = menu;
    
    // 打开vpn
    NSMenuItem *disableItem = [[NSMenuItem alloc]initWithTitle:@"退出" action:@selector(quit) keyEquivalent:@""];
    [disableItem setTarget:self];
    [menu addItem:disableItem];
    
}

- (void)quit{
    [[NSApplication sharedApplication] terminate:nil];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
