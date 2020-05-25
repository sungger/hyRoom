//
//  AppUtils.m
//  zlydoc+iphone
//
//  Created by Ryan on 14+5+23.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "AppUtils.h"
#import <CommonCrypto/CommonDigest.h>

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation AppUtils

///********************* System Utils **********************/
//+ (void)showAlertMessage:(NSString *)msg
//{
//    UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//    [alert show];
//}

+ (void)closeKeyboard
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

+ (NSString *)md5FromString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


/********************** NSDate Utils ***********************/
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateString];
}

/********************* Category Utils **********************/
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/********************* Verification Utils **********************/
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|47)\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|73|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:phoneNumber] == YES)
       || ([regextestcm evaluateWithObject:phoneNumber] == YES)
       || ([regextestct evaluateWithObject:phoneNumber] == YES)
       || ([regextestcu evaluateWithObject:phoneNumber] == YES)){
        return YES;
    }else{
        return NO;
    }
}

//+ (void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd andUserId:(NSString *)userId andNickName:(NSString *)nickName andUserPic:(NSString *)pic
//{
//    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//    [settings removeObjectForKey:@"userName"];
//    [settings removeObjectForKey:@"password"];
//    [settings removeObjectForKey:@"userId"];
//    [settings removeObjectForKey:@"nickName"];
//    [settings removeObjectForKey:@"pic"];
//    [settings setObject:userName forKey:@"userName"];
//    [settings setObject:userId forKey:@"userId"];
//    [settings setObject:nickName forKey:@"nickName"];
//    [settings setObject:pic forKey:@"pic"];
//
//    pwd = [AESCrypt encrypt:pwd password:@"pwd"];
//
//    [settings setObject:pwd forKey:@"password"];
//    [settings synchronize];
//}

+ (NSString *)getUserName
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"userName"];
}
+ (NSString *)getUserPic
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"pic"];
}

//+ (NSString *)getPwd
//{
//    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//    NSString * temp = [settings objectForKey:@"password"];
//    return [AESCrypt decrypt:temp password:@"pwd"];
//}

+ (NSString *)getUserId
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString *value = [setting objectForKey:@"userId"];
    if (value.length !=0)
    {
        return value;
    }
    else
    {
        return nil;
    }
}

+ (NSString *)getNickName
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString *value = [setting objectForKey:@"nickName"];
    if (value.length !=0)
    {
        return value;
    }
    else
    {
        return nil;
    }
}

//+ (BOOL)checkLogin
//{
//    if ([self getUserName] && [self getPwd] && [self getUserId]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

+ (NSString*)dictToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (!jsonData) //如果为空
    {
        NSLog(@"错误: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    //去除掉首尾的空白字符和换行字符
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return jsonString;
}

+ (NSString *)noWhiteSpaceString:(NSString *) newString{
//    NSString *newString = self;
    //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    return newString;
}

#pragma mark ---- 将时间戳转换成时间

+ (NSString *)getTimeFromTimestamp:(long) time{
    //将对象类型的时间转换为NSDate类型
//    double time =1504667976;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
    
}

///设置图片
+ (UIImage *)resizeImage:(UIImage *)sourceImage toMaxWidthAndHeight:(CGFloat)maxValue {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width > height && width > maxValue) {
        height = height * (maxValue / width);
        width = maxValue;
    }else if (height > width && height > maxValue) {
        width = width * (maxValue / height);
        height = maxValue;
    }else {
        return sourceImage;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0, 0, width, height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
