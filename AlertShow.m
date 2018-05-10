//
//  AlertShow.m
//  App_iOS
//
//  Created by Dafiger on 17/1/10.
//  Copyright © 2017年 wpf. All rights reserved.
//

#import "AlertShow.h"

//#define AlertShowHeight 40.0f + 40.0f + 40.0f
#define AlertShowWidth 270.0f
#define SystemBtnColor RGB_COLOR(42, 148, 229)

@implementation AlertShow

- (id)initWithTitleStr:(NSString *)titleStr
            contentStr:(NSString *)contentStr
                btnAry:(NSArray *)btnAry
{
    // 计算内容的高度
    CGSize size = [ToolForCoding jisuanSizeWithContent:contentStr fontSize:15.0f constraintSize:CGSizeMake(AlertShowWidth - 2*20, MAXFLOAT)];
    float contentHeight = size.height;
    
    if (contentHeight < 40.0f) {
        contentHeight = 40.0f;
    }else {
        contentHeight += 20.0f;
    }
    self.contentHeight = contentHeight;
    
    float allViewHeight = 40 + self.contentHeight + 40;
    return [self initWithFrame:CGRectMake(0, 0, AlertShowWidth, allViewHeight)
               titleStr:titleStr
             contentStr:contentStr
                 btnAry:btnAry];
}

- (id)initWithFrame:(CGRect)frame
           titleStr:(NSString *)titleStr
         contentStr:(NSString *)contentStr
             btnAry:(NSArray *)btnAry
{
    self = [super initWithFrame:frame];
    if (self) {
        self.allHeight = 0;
        
        if (kStringIsEmpty(titleStr)) {
            self.titleStr = @"";
        }else{
            self.titleStr = titleStr;
        }
        if (kStringIsEmpty(contentStr)) {
            self.contentStr = @"";
        }else{
            self.contentStr = contentStr;
        }
        
        self.btnAry = btnAry;
        if (kArrayIsEmpty(btnAry)) {
            self.otherBtnStr = @"关闭";
        }else if(btnAry.count == 1){
            self.otherBtnStr = btnAry[0];
        }else if(btnAry.count == 2){
            self.leftBtnStr = btnAry[0];
            self.rightBtnStr = btnAry[1];
        }
        
//        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = TRUE;
        self.backgroundColor = [UIColor whiteColor];
        
        // title部分
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, AlertShowWidth, 20)];
        [self addSubview:titleLab];
        [ToolForCoding initWihtLabel:titleLab
                               color:TextColor
                            fontSize:17.0f
                                line:1
                           alignment:NSTextAlignmentCenter];
        titleLab.text = self.titleStr;
        titleLab.font = FONTBlod(17.0f);
        self.allHeight = 40.0f;
        
        // 中间部分 CGRectMake(0, self.allHeight, AlertShowWidth, self.contentHeight)
        UIView *middleView = [[UIView alloc] init];
        [self addSubview:middleView];
        [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets padding = UIEdgeInsetsMake(40, 0, 40, 0);
            make.edges.equalTo(self).insets(padding);
        }];
        middleView.backgroundColor = [UIColor whiteColor];
        
        UILabel *contentLab = [[UILabel alloc] init];
        [middleView addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets padding = UIEdgeInsetsMake(0, 20, 0, 20);
            make.edges.equalTo(middleView).insets(padding);
        }];
        [ToolForCoding initWihtLabel:contentLab
                               color:TextColor
                            fontSize:15.0f
                                line:0
                           alignment:NSTextAlignmentCenter];
        contentLab.text = self.contentStr;
        self.allHeight += self.contentHeight;
        
        // 底部部分
        self.allHeight += 40;
        
        //线 CGRectMake(0, self.allHeight, AlertShowWidth, 1)
        UIView *line1 = [[UILabel alloc] init];
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_bottom).offset(-40.5);
            make.bottom.equalTo(self.mas_bottom).offset(-40);
        }];
        line1.backgroundColor = LineColor;
        
        if (btnAry.count == 2) {
            // 两个按钮 CGRectMake(AlertShowWidth/2.0, self.allHeight, 1, 40)
            UIView *line2 = [[UILabel alloc] init];
            [self addSubview:line2];
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(AlertShowWidth/2.0);
                make.bottom.equalTo(self.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(0.5, 40));
            }];
            line2.backgroundColor = LineColor;
            
            // 左边按钮
            UIButton *leftBtn = [[UIButton alloc] init];
            [self addSubview:leftBtn];
            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.bottom.equalTo(self.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(AlertShowWidth/2.0, 40));
            }];
            leftBtn.backgroundColor = [UIColor whiteColor];
//            [leftBtn setBackgroundImage:[ToolForCoding createImageWithColor:[UIColor whiteColor]]
//                               forState:UIControlStateNormal];
            
            [leftBtn addTarget:self
                        action:@selector(leftBtnClick:)
              forControlEvents:UIControlEventTouchUpInside];
            [leftBtn setTitle:self.leftBtnStr forState:UIControlStateNormal];
            [leftBtn setTitleColor:SystemBtnColor forState:UIControlStateNormal];
            leftBtn.titleLabel.font = FONTBlod(17.0f);
            leftBtn.layer.masksToBounds = YES;
            [leftBtn setShowsTouchWhenHighlighted:YES];
            
            // 右边按钮
            UIButton *rightBtn = [[UIButton alloc] init];
            [self addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(AlertShowWidth/2.0 + 1);
                make.bottom.equalTo(self.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(AlertShowWidth/2.0, 40));
            }];
            rightBtn.backgroundColor = [UIColor whiteColor];
//            [rightBtn setBackgroundImage:[ToolForCoding createImageWithColor:[UIColor whiteColor]]
//                                forState:UIControlStateNormal];
            
            [rightBtn addTarget:self
                         action:@selector(rightBtnClick:)
               forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setTitle:self.rightBtnStr forState:UIControlStateNormal];
            [rightBtn setTitleColor:SystemBtnColor forState:UIControlStateNormal];
            rightBtn.titleLabel.font = FONTBlod(17.0f);
            rightBtn.layer.masksToBounds = YES;
            [rightBtn setShowsTouchWhenHighlighted:YES];
        }else{
            // 一个按钮
            UIButton *btn = [[UIButton alloc] init];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.bottom.equalTo(self.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(AlertShowWidth, 40));
            }];
            btn.backgroundColor = [UIColor whiteColor];
//            [btn setBackgroundImage:[ToolForCoding createImageWithColor:[UIColor whiteColor]]
//                           forState:UIControlStateNormal];
            
            [btn addTarget:self
                    action:@selector(otherBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:self.otherBtnStr forState:UIControlStateNormal];
            [btn setTitleColor:SystemBtnColor forState:UIControlStateNormal];
            btn.titleLabel.font = FONTBlod(17.0f);
            btn.layer.masksToBounds = YES;
            [btn setShowsTouchWhenHighlighted:YES];
        }
    }
    return self;
}

#pragma mark - 点击事件
- (void)leftBtnClick:(UIButton *)btn
{
    self.leftBtnAction(@"左按钮事件");
    [self dismissFromWin];
}

- (void)rightBtnClick:(UIButton *)btn
{
    self.rightBtnAction(@"右按钮事件");
    [self dismissFromWin];
}

- (void)otherBtnClick:(UIButton *)btn
{
    if (kArrayIsEmpty(self.btnAry)) {
        [self dismissFromWin];
    }else{
        self.otherBtnAction(@"关闭按钮事件");
        [self dismissFromWin];
    }
}

#pragma mark - show
- (void)showInWin
{
    if (nil == self.controlForDismiss) {
        self.controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.controlForDismiss.backgroundColor = RGBA_COLOR(39, 41, 47, 0.5f);
    }
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (self.controlForDismiss) {
        [keywindow addSubview:self.controlForDismiss];
    }
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self animatedIn];
}

#pragma mark - dismiss
- (void)dismissFromWin
{
    [self animatedOut];
}

#pragma mark - 动画
- (void)animatedIn
{
//    self.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    self.alpha = 0.0;
//    [UIView animateWithDuration:0.15 animations:^{
//        self.alpha = 1;
//        self.transform = CGAffineTransformMakeScale(1, 1);
//    }];
}

- (void)animatedOut
{
//    [UIView animateWithDuration:0.10 animations:^{
//        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
//        self.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            if (self.controlForDismiss) {
//                [self.controlForDismiss removeFromSuperview];
//            }
//            [self removeFromSuperview];
//        }
//    }];
    
    if (self.controlForDismiss) {
        [self.controlForDismiss removeFromSuperview];
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
