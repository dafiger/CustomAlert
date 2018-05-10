//
//  AlertShow.h
//  App_iOS
//
//  Created by Dafiger on 17/1/10.
//  Copyright © 2017年 wpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertShow : UIView

typedef void(^btnAction)(NSString *msgStr);

@property (nonatomic, strong) UIControl *controlForDismiss;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, assign) float allHeight;
@property (nonatomic, assign) float contentHeight;

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *contentStr;

@property (nonatomic, strong) NSArray *btnAry;
@property (nonatomic, strong) NSString *leftBtnStr;
@property (nonatomic, strong) NSString *rightBtnStr;
@property (nonatomic, strong) NSString *otherBtnStr;

// 两个按钮
@property (nonatomic, strong) btnAction leftBtnAction;
@property (nonatomic, strong) btnAction rightBtnAction;
// 一个按钮
@property (nonatomic, strong) btnAction otherBtnAction;

- (id)initWithTitleStr:(NSString *)titleStr
            contentStr:(NSString *)contentStr
                btnAry:(NSArray *)btnAry;

- (id)initWithFrame:(CGRect)frame
           titleStr:(NSString *)titleStr
         contentStr:(NSString *)contentStr
             btnAry:(NSArray *)btnAry;

- (void)showInWin;
- (void)dismissFromWin;

@end


//// 一个点击事件
//AlertShow *alertShow3 = [[AlertShow alloc] initWithTitleStr:@"提示"
//                                                 contentStr:@"内容"
//                                                     btnAry:@[@"知道了"]];
//alertShow3.otherBtnAction = ^(NSString *msgStr){
//    NSLog(@"%@",msgStr);
//};
//[alertShow3 showInWin];
//
//// 无点击事件
//AlertShow *alertShow2 = [[AlertShow alloc] initWithTitleStr:@"提示"
//                                                 contentStr:@"内容"
//                                                     btnAry:nil];
//[alertShow2 showInWin];
//
//// 两个点击事件
//AlertShow *alertShow1 = [[AlertShow alloc] initWithTitleStr:@"提示"
//                                                 contentStr:@"内容"
//                                                     btnAry:@[@"确定", @"取消"]];
//alertShow1.leftBtnAction = ^(NSString *msgStr){
//    NSLog(@"%@",msgStr);
//};
//alertShow1.rightBtnAction = ^(NSString *msgStr){
//    NSLog(@"%@",msgStr);
//};
//[alertShow1 showInWin];


