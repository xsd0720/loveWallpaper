//
//  AppDelegate.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/19.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "NSView+Extension.h"
#import "XXScrollView.h"
#import "BannerScollView.h"
@interface AppDelegate ()<NSWindowDelegate>

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) NSStatusItem *demoItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    [[NSApplication sharedApplication] setPresentationOptions:NSApplicationPresentationAutoHideMenuBar];
    
    NSUInteger style =  NSWindowStyleMaskTitled|NSWindowStyleMaskFullSizeContentView;
    float w = [[NSScreen mainScreen] frame].size.width;
    float h = [[NSScreen mainScreen] frame].size.height;
    
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, w, h) styleMask:style backing:NSBackingStoreBuffered defer:YES];
    self.window.titlebarAppearsTransparent = true;
    self.window.titleVisibility = NSWindowTitleHidden;
//    self.window.styleMask |= NSWindowStyleMaskFullSizeContentView;
    
    [self.window makeKeyAndOrderFront:self];
    [self.window center];
    self.homeVC = [[HomeViewController alloc] init];
//    [self.window setContentViewController:self.homeVC];
    self.window.contentView.backgroundColor = [NSColor blackColor];
    [self.window.contentView addSubview:self.homeVC.view];

    
    [self.window setReleasedWhenClosed:NO];
    [self configStatusBar];
    [self configMainMenu];
    
    [self checkVersion];
}

- (void)checkVersion{
    [HttpTool GET:@"http://api.breaker.club/wallpaper/version" parameters:NULL success:^(NSDictionary *responsObject) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *cur = responsObject[@"version"];
        NSString *ser = infoDictionary[@"CFBundleVersion"];
        NSInteger c = [NSString compareVersion:cur to:ser];
        if (c == 1) {
            [self shouldUpdate];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)shouldUpdate{
    NSAlert *alert = [[NSAlert alloc]init];
    //可以设置产品的icon
    //添加两个按钮吧
    [alert addButtonWithTitle:@"更新"];
    [alert addButtonWithTitle:@"取消"];
    //正文
    alert.messageText = @"版本更新";
    //描述文字
    alert.informativeText = @"发现新版本";
    //弹窗类型 默认类型 NSAlertStyleWarning
    [alert setAlertStyle:NSAlertStyleWarning];
    //回调Block
    [alert beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn ) {
            NSLog(@"this is OK Button tap");
        }else if (returnCode == NSAlertSecondButtonReturn){
            NSLog(@"this is Cancel Button tap");
        }
    }];
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

- (void)configMainMenu{
    NSMenu *menu = [[NSMenu alloc] init];

    NSMenuItem * appItem = [[NSMenuItem alloc] initWithTitle:@"love" action:Nil keyEquivalent:@""];
    [menu addItem:appItem];
    // this title will be ignore too
    NSMenu *appMenu = [[NSMenu alloc] init];
    NSMenuItem *aboutItem  = [[NSMenuItem alloc] initWithTitle:@"hidden" action:@selector(abc) keyEquivalent:@""];
    [appMenu addItem:aboutItem];
    [appMenu addItem:[NSMenuItem separatorItem]];
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"quit" action:@selector(quit) keyEquivalent:@""];
    [appMenu addItem:quitItem];
    [menu setSubmenu:appMenu forItem:appItem];
//    [NSMenu setMenuBarVisible:NO];
//    [self.window mak]
    
//    [[NSApplication sharedApplication] setMenu:menu];
    

}

- (void)abc{
    [self.window orderOut:nil];
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return NO;
}
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    if(!flag)
    {
        [NSApp activateIgnoringOtherApps:NO];
        [self.window makeKeyAndOrderFront:self];
    }
    return YES;
}
- (void)quit{
    [[NSApplication sharedApplication] terminate:nil];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)windowDidResize:(NSNotification *)notification{
    NSWindow *win = [notification object];
//    [win.contentView.subviews performSelector:@selector(layoutSublayers)];
    for (NSView *v in win.contentView.subviews) {
        v.frame = win.contentView.bounds;
    }
    
}

//- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize{
//
//}

@end
