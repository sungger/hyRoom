//
//  WisTools.h
//  wisdomCommunity
//
//  Created by Vivian on 2019/3/11.
//  Copyright © 2019 yzworld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WisTools : NSObject

/**检查有没有表情*/
+ (BOOL)stringContainsEmoji:(NSString *)string;
/** 检查是否只包含字母和数字*/
+ (BOOL)checkLeterAndNumber:(NSString *)str;
/** 检验手机*/
+ (BOOL)checkTel:(NSString *)str;
/** 检验空字符*/
+ (BOOL)checkEmpty:(id)str;
/** 检查是否包含特殊字符串*/
+ (BOOL)hasSpecialString:(NSString *)str;

/** 检验userdeafult空键符并返回字符*/
+ (NSString *)checkEmptyKey:(id)str;
/** 检验空字符并返回字符*/
+ (NSString *)returnCheckEmptyString:(id)str;
/** 检验数字格式并返回*/
+ (NSString *)checkAmountString:(NSString *)str;
/** json转nsdictionary或者array*/
+ (id)JSONValue:(NSString *)str;
+ (NSString *)stringJsonWithValue:(id)data;
/** 校验11位手机号*/
+ (BOOL)isPhoneNumber:(NSString *)num;
/** 检查网络状态*/
+ (int)checkNetWorkStatus;
/** 检查是否为汉字*/
+ (BOOL)checkIsChinese:(NSString *)str;

+ (void)openURLInBrowser:(NSString *) URL;

/** 获取手机号*/
+ (NSString *) getCommonPhoneNum:(NSString *) str;

/** 获取字体大小*/
+ (CGSize)getFontSizeWithMaxWidth:(CGFloat) width textFont:(UIFont *) font text:(NSString *)text;

/** html转换*/
+ (NSString *)convertHtmlLabel:(NSString *)html;

/** 距离转换*/
+ (NSString *)convertDistance:(NSString *)distance;

/** 金额转换*/
+ (NSString *)convertAmt:(NSString *)amt;

/**车牌正则*/
+(BOOL)isCarPlate:(NSString *)plate;

/**身份证正则*/
+(BOOL)isIDCard:(NSString *)userID;

/**正负数正则*/
+ (BOOL)priceFormat:(NSString *)price;

/**
 *画圆角
 */
+ (void)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size andimageV:(UIImageView *)imageV;

+(CAShapeLayer *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

/**
 *时间戳转为时间
 */
+ (NSString *)TimeStamp:(NSString *)strTime andType:(NSString *)type;
//时间转时间戳
+ (NSString *)getStringWithToShijianCuo:(NSString *)str
                              andFormat:(NSString *)format;
/**
 *按位数保留小数位数
 */
+ (NSString *)formatFloat:(float)f;

/**
 *中划线
 */
+(NSMutableAttributedString *)addHuaxianText:(NSString *)textStr;
/**
 * 改变颜色
 */
+(NSAttributedString *)changeWith:(NSString *)string range:(NSRange)range color:(UIColor *)color;
+(NSAttributedString *)changeWith:(NSString *)string range:(NSRange)range font:(double)font;


/**
 *  检测麦克风权限，仅支持iOS7.0以上系统
 *
 *  @return 准许返回YES;否则返回NO
 */
+(BOOL)isMicrophonePermissionGranted;

/**
 *  检测相机权限
 *
 *  @return 准许返回YES;否则返回NO
 */
+(BOOL)isCapturePermissionGranted;

/**
 *  检测相册权限
 *
 *  @return 准许返回YES;否则返回NO
 */
//+(BOOL)isAssetsLibraryPermissionGranted;


@end

NS_ASSUME_NONNULL_END
