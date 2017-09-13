//
//  KeyboardManager.h
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-14 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#ifndef KeyboardManager_h
#define KeyboardManager_h

#import "IQBarButtonItem.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardManagerConstants.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQSegmentedNextPrevious.h"
#import "IQTextView.h"
#import "IQTitleBarButtonItem.h"
#import "IQToolbar.h"
#import "IQUIView+Hierarchy.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQUIWindow+Hierarchy.h"

#endif


//
//////////////使用方法//////////////////
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = NO;
//
//    return YES;
//}

//    enable   控制整个功能是否启用。

//    shouldResignOnTouchOutside   控制点击背景是否收起键盘。

//    shouldToolbarUsesTextFieldTintColor  控制键盘上的工具条文字颜色是否用户自定义。

//    enableAutoToolbar    控制是否显示键盘上的工具条。
