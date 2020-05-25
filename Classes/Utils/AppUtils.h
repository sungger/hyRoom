//
//  AppUtils.h
//  zlydoc+iphone
//
//  Created by Ryan on 14+5+23.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
@interface AppUtils : NSObject

/********************** System Utils ***********************/
//弹出UIAlertView
//+ (void)showAlertMessage:(NSString *)msg;
//关闭键盘
+ (void)closeKeyboard;
//获取MD5加密后字符串
+ (NSString *)md5FromString:(NSString *)str;

/********************** NSDate Utils ***********************/
//根据指定格式将NSDate转换为NSString
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
//根据指定格式将NSString转换为NSDate
+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;

/********************* Category Utils **********************/
//根据颜色码取得颜色对象
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/********************* Verification Utils **********************/
//验证手机号码合法性（正则）
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;
//保存登录用户名以及密码
//+ (void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd andUserId:(NSString *)userId andNickName:(NSString *)nickName andUserPic:(NSString *)pic;
+ (NSString *)getUserName;
//+ (NSString *)getPwd;
+ (NSString *)getUserId;
+ (NSString *)getNickName;
+ (NSString *)getUserPic;
//检查是否登录
//+ (BOOL)checkLogin;
+ (NSString*)dictToJSONData:(id)dic;
+ (NSString *)getTimeFromTimestamp:(long) time;
+ (UIImage *)resizeImage:(UIImage *)sourceImage toMaxWidthAndHeight:(CGFloat)maxValue ;
@end
