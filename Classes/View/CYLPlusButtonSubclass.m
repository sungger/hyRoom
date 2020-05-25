//
//  CYLPlusButtonSubclass.m
//  CYLTabBarControllerDemo
//
//  v1.21.x Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 15/10/24.
//  Copyright (c) 2018年 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLPlusButtonSubclass.h"
#import "CYLMineViewController.h"

@interface CYLPlusButtonSubclass () {
    CGFloat _buttonImageHeight;
}

@property(nonatomic, strong) UIView *blackView;

@end

@implementation CYLPlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    // 控件大小,间距大小
//    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
//    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
//    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
//
//    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
//    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
//    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
//
//    // imageView 和 titleLabel 中心的 Y 值
//    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
//    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
//
//    //imageView position 位置
//    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
//    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
//
//    //title position 位置
//    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
//    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
//}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    CYLPlusButtonSubclass *button = [[CYLPlusButtonSubclass alloc] init];
    UIImage *normalButtonImage = [UIImage imageNamed:@"post_normal"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"post_highlight"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateHighlighted];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    //    UIImage *normalButtonBackImage = [UIImage imageNamed:@"videoback"];
    //    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
    //    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    button.frame = CGRectMake(0.0, 0.0, 55, 59);
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
//+ (id)plusButton
//{
//
//    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];
//
//    CYLPlusButtonSubclass* button = [CYLPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
//
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//
//    return button;
//}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
//    CYLTabBarController *tabBarController = [self cyl_tabBarController];
//    UIViewController *viewController = tabBarController.selectedViewController;
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
//    [actionSheet showInView:viewController.view];
//#pragma clang diagnostic pop
    [[UIApplication sharedApplication].keyWindow addSubview:self.blackView];
    [UIView animateWithDuration:0.3 animations:^{
        self.blackView.viewY = 0;
    }];
}

-(UIView *)blackView{
    if (!_blackView) {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  KScreenWidth, KScreenHeight)];
        _blackView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
        [self setMenu];
    }
    return _blackView;
}

- (void)setMenu{
    CGFloat wh = KScreenWidth/4.0;
    NSArray *arrTitle = @[@"创建圈子",@"分享学术",@"发布房源",@"发现好友"];
    NSArray *ary = @[@"createCircle",@"shareScience",@"issueHouse",@"findFriends"];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,AdaptationRatio(140))];
    whiteView.backgroundColor = KWhiteColor;
    [whiteView align:ViewAlignmentBottomLeft relativeToPoint:CGPointMake(0, KScreenWidth - security_height)];
    [whiteView setFTCornerdious:AdaptationRatio(10)];
    [_blackView addSubview:whiteView];
    
    UIButton *dissBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth/2.0, AdaptationRatio(50))];
    [dissBtn align:ViewAlignmentTopCenter relativeToPoint:CGPointMake(KScreenWidth/2.0, AdaptationRatio(90))];
    [dissBtn setImage:IMAGE_NAMED(@"popPlus") forState:0];
    [dissBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:dissBtn];
    
    for (int i = 0; i < arrTitle.count; i++) {
        
        UIImageView *imaegV = [[UIImageView alloc] initWithImage:IMAGE_NAMED(ary[i])];
        imaegV.viewSize = [IMAGE_NAMED(ary[i]) size];
        [imaegV align:ViewAlignmentTopCenter relativeToPoint:CGPointMake(wh*i+wh/2.0, AdaptationRatio(20))];
        [whiteView addSubview:imaegV];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(wh*i, imaegV.viewBottomEdge + AdaptationRatio(10), wh, AdaptationRatio(20))];
        infoLabel.text = arrTitle[i];
        infoLabel.font = [UIFont systemFontOfSize:AdaptationRatio(12)];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:infoLabel];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(wh*i, 0, wh, AdaptationRatio(90))];
        btn.tag = i+10000;
        [btn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:btn];
    }
}
-(void)chooseBtn:(UIButton *)sender{
//    CYLTabBarController *tabBarController = [self cyl_tabBarController];
//    UIViewController *viewController = tabBarController.selectedViewController;
//
//    if (sender.tag == 10000) {
//        //纯文本
//        CreateCircleInfoViewController *publishTextVC = [[CreateCircleInfoViewController alloc] init];
//        [publishTextVC.navigationItem setTitle:@"创建圈子"];
//        [publishTextVC toDissmissSelf:^{
//
//        }];
//        [viewController cyl_pushViewController:publishTextVC animated:YES];
//    }else if(sender.tag == 10001){
//        //图文
//        IssueScienceInfoViewController *info=[[IssueScienceInfoViewController alloc] init];
//
////        ScienceIndexViewController *publishVC = [[ScienceIndexViewController alloc] init];
////        [publishVC.navigationItem setTitle:@"分享学术"];
////        [publishVC toDissmissSelf:^{
////
////        }];
//        [viewController cyl_pushViewController:info animated:YES];
//
//    }else if(sender.tag == 10002){
//        //链接
//        IssueHouseInfoViewController *publishLinkVC = [[IssueHouseInfoViewController alloc] init];
//        [publishLinkVC.navigationItem setTitle:@"发布房源"];
//        [publishLinkVC toDissmissSelf:^{
//        }];
//        [viewController cyl_pushViewController:publishLinkVC animated:YES];
//    }else{
//        //链接
//        FoundFriendViewController *publishLinkVC = [[FoundFriendViewController alloc] init];
//        [publishLinkVC.navigationItem setTitle:@"发现好友"];
//        [publishLinkVC toDissmissSelf:^{
//
//        }];
//        [viewController cyl_pushViewController:publishLinkVC animated:YES];
//    }
//
//    [self dissMiss];
}

-(void)dissMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.blackView.viewY = KScreenHeight;
    }completion:^(BOOL finished) {
        if (finished) {
            [self.blackView removeFromSuperview];
        }
    }];
}

#pragma mark - UIActionSheetDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}
#pragma clang diagnostic pop
#pragma mark - CYLPlusButtonSubclassing

+ (UIViewController *)plusChildViewController {
    UIViewController *plusChildViewController = [[UIViewController alloc] init];
    plusChildViewController.view.backgroundColor = [UIColor redColor];
    plusChildViewController.navigationItem.title = @"PlusChildViewController";
    UIViewController *plusChildNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:plusChildViewController];
    return plusChildNavigationController;
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}

+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 6 : 4);
}

//+ (NSString *)tabBarContext {
//    return NSStringFromClass([self class]);
//}

@end
