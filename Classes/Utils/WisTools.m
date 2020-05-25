//
//  WisTools.m
//  wisdomCommunity
//
//  Created by Vivian on 2019/3/11.
//  Copyright © 2019 yzworld. All rights reserved.
//

#import "WisTools.h"

#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@implementation WisTools


//MARK: 是否是电话
+ (BOOL)isPhoneNumber:(NSString *)num{
    NSString * re = @"^[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", re];
    return [pred evaluateWithObject:num];
}

+ (NSAttributedString *)capsCaracter:(NSString *)str{
    NSMutableAttributedString * textAttr = [[NSMutableAttributedString alloc]initWithString:str];
    [textAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, 1)];
    
    return textAttr;
}

#pragma mark - 网络监测
+ (int)checkNetWorkStatus
{
    // 关闭检测
    [[AFNetworkReachabilityManager sharedManager]stopMonitoring];

    // 当网络变更的时候会调用这个方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString * msg = nil;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                msg = @"未识别的网络😭";
                NSLog(@"未识别网络");
                [MBProgressHUD showErrorMessage:@"暂无网络连接"];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                msg = @"当前网络不可用❌";
                NSLog(@"网络不可用");
                [MBProgressHUD showErrorMessage:@"暂无网络连接"];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                msg = @"当前使用WiFi网络🌐";
                NSLog(@"wifi");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                msg = @"当前使用蜂窝数据⭐️";
                NSLog(@"蜂窝");
            }
                break;
            default:
                break;
        }
        // 提示用户
        //        [APP_DELEGATE().window makeToast:msg duration:2 position:CSToastPositionTop];
    }];
    // 开启检测
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    return (int)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

//检查是否只包含字母和数字
+ (BOOL)checkLeterAndNumber:(NSString *)str
{
    
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
    
}

+ (BOOL)checkTel:(NSString *)str

{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * MOBILE = @"[0-9]{11}";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，183
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189,173
     22         */
    NSString * CT = @"^1((33|47|49|53|73|77|76|8[0-9])[0-9]|349)\\d{7}$";
    
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
    
    if(([regextestmobile evaluateWithObject:str] == YES)
       || ([regextestcm evaluateWithObject:str] == YES)
       || ([regextestct evaluateWithObject:str] == YES)
       || ([regextestcu evaluateWithObject:str] == YES)){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 检查有没有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark - 禁止输入表情
+ (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (BOOL)checkEmpty:(id)string{
    
    if ([string isKindOfClass:[NSNull class]]) {
        return true;
    }
    
    
    if ([string isKindOfClass:[NSNumber class]]) { //如果是数字 //不能验证数字
        return false;
    }
    
    NSString *str;
    
    if (![string isKindOfClass:[NSString class]]) {
        str = [NSString stringWithFormat:@"%@",string];
    }else{
        str = string;
    }
    
    //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
    NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
    
    if ([trimedString length] == 0) {
        return true;
    }
    
    
    if( nil == str || (0 == str.length && ![str isEqualToString:@""]) ||[str.description isEqualToString:@"(null)"] ||[str isEqualToString:@""]){
        return true;
    }else{
        return false;
    }
    
}


+(id)JSONValue:(NSString *)str;
{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(NSString *)stringJsonWithValue:(id)data {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    return jsonString;
}


//检验userdeafult空键符并返回字符
+ (NSString *)checkEmptyKey:(id)str{
    
    NSUserDefaults *deafults = [NSUserDefaults standardUserDefaults];
    return [WisTools checkEmpty:[deafults objectForKey:str]]?nil:[deafults objectForKey:str];
}

//检验空字符并返回字符
+ (NSString *)returnCheckEmptyString:(id)str{
    
    return [WisTools checkEmpty:str]?@"":[NSString stringWithFormat:@"%@",str];
}

+ (NSString *)checkAmountString:(NSString *)string
{
    NSString *str;
    //处理数字格式
    if ([string rangeOfString:@"."].location != NSNotFound ) {
        //含小数点
        NSArray * sepArr = [string componentsSeparatedByString:@"."];
        str = sepArr[0];
        str = [str substringWithRange:NSMakeRange(str.length%3, str.length-str.length%3)];
        NSString *strs = [string substringWithRange:NSMakeRange(0, string.length%3)];
        for (int  i =0; i < str.length; i =i+3) {
            NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
            strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
        }
        if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
            strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
        }
        return [NSString stringWithFormat:@"%@.%@",strs,sepArr[1]];
    }else{
        //无小数点
        str = [string substringWithRange:NSMakeRange(string.length%3, string.length-string.length%3)];
        NSString *strs = [string substringWithRange:NSMakeRange(0, string.length%3)];
        for (int  i =0; i < str.length; i =i+3) {
            NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
            strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
        }
        if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
            strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
        }
        CGFloat f = [strs floatValue];
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

+ (BOOL)priceFormat:(NSString *)price{
    
    if (price.length > 0) {
        NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,3}))|([1-9]\\d{0,20}(([.]\\d{0,2})?)))?";
        NSPredicate *pricePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        if ([pricePredicate evaluateWithObject:price] == NO) {// 不满足该正则，就不让用户输入，执行return NO。
            return NO;
        }
    }
    // 满足该正则，让用户输入，执行return YES
    return YES;
}

#pragma mark - 检查是否包含特殊字符串
+ (BOOL)hasSpecialString:(NSString *)str{
    
    if (str.length <1) {
        return false;
    }
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-,;:*+=）\\|~(＜＞$,'%^&*)_+？? "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    
    return range.location<str.length;
}

#pragma mark - 判断字节长度
+(int)charNumber:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

#pragma mark - 检验邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//MARK: 是否是汉字
+ (BOOL)checkIsChinese:(NSString *)str{
    NSString * re = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",re];
    return [pred evaluateWithObject:str];
}

+ (void)openURLInBrowser:(NSString *)URL{
    NSArray * array = [URL componentsSeparatedByString:@"#headertop"];
    NSURL * url = [NSURL URLWithString:array.firstObject];
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:url options:@{}
               completionHandler:^(BOOL success) {
                   if (!success) {
//                       [SVProgressHUD showErrorWithStatus:@"网页链接有误"];
                   }
                   NSLog(@"Open %@: %d",URL,success);
               }];
        } else {
            // Fallback on earlier versions
        }
    } else {
        BOOL success = [application openURL:url];
        if (!success) {
//            [SVProgressHUD showErrorWithStatus:@"网页链接有误"];
        }
        NSLog(@"Open %@: %d",URL,success);
    }
}

//MARK: 获取手机号
+ (NSString *) getCommonPhoneNum:(NSString *) str {
    
    NSArray *arr = [str componentsSeparatedByString:@" "];
    
    NSString *newStr = [arr componentsJoinedByString:@""];
    
    return newStr;
    
}

+ (CGSize)getFontSizeWithMaxWidth:(CGFloat) width textFont:(UIFont *) font text:(NSString *)text{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size;
}

+ (NSString *)convertCount:(NSInteger)count{
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    if (count >= 10000) {
        return [NSString stringWithFormat:@"%@万",[numFormatter stringFromNumber:[NSNumber numberWithInteger:count/10000]]];
    }
    return [numFormatter stringFromNumber:[NSNumber numberWithInteger:count]];
}

//将 &lt 等类似的字符转化为HTML中的“<”等
+ (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{
                              NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)
                              };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//去掉 HTML 字符串中的标签
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    NSScanner * scanner2 = [NSScanner scannerWithString:html];
    NSString * text2 = nil;
    while([scanner2 isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner2 scanUpToString:@"&" intoString:nil];
        //找到标签的结束位置
        [scanner2 scanUpToString:@";" intoString:&text2];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;",text2] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
+ (NSString *)convertHtmlLabel:(NSString *)html{
    //1.将字符串转化为标准HTML字符串
    //    html = [self htmlEntityDecode:html];
    //2.将HTML字符串转换为attributeString
    return [self filterHTML:html];
}

+ (NSString *)convertDistance:(NSString *)distance{
    NSString * finalDist;
    NSInteger dist = [distance integerValue];
    if (dist > 1000) {
        //        if (dist > 10000) {
        //            finalDist = @">10km";
        //        }else{
        finalDist = [NSString stringWithFormat:@"%ld km",dist/1000];
        //        }
    }else{
        finalDist = [NSString stringWithFormat:@"%ldm",dist];
    }
    return finalDist;
}

+ (NSString *)convertAmt:(NSString *)amt{
    NSString * str = [NSString stringWithFormat:@"%.2f",[amt floatValue]/100];
    return str;
}

/**车牌正则*/
+(BOOL)isCarPlate:(NSString *)plate{
    if (plate.length!=7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{4}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:plate];
    
    return YES;
}

/**身份证正则*/
+(BOOL)isIDCard:(NSString *)userID{
    //长度不为18的都排除掉
    if (userID.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:userID];
}


//图片圆角

+ (void)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size andimageV:(UIImageView *)imageV{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    [imageV.image drawInRect:rect];
    
    imageV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

+(CAShapeLayer *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = CGRectMake(0, 0, size.width,size.height);
    mask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width,size.height) cornerRadius:radius].CGPath;
    return mask;
}

//时间戳转时间
+ (NSString *)TimeStamp:(NSString *)strTime andType:(NSString *)type
{
    if (!strTime || !type) {
        return @"";
    }
    NSString *str = [NSString stringWithFormat:@"%@",strTime];
    if (str.length > 10) {
        str = [str substringToIndex:10];
    }
    
    NSTimeInterval time=[str doubleValue];
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:type];
    
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
}

+ (NSString *)getStringWithToShijianCuo:(NSString *)str
                              andFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd HH:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    NSDate* date = [formatter dateFromString:str]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return [NSString stringWithFormat:@"%ld",(long)timeSp]; //时间戳的值
}

/**
 *按位数保留
 */
+ (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

/**
 *中划线
 */
+(NSMutableAttributedString *)addHuaxianText:(NSString *)textStr{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    return attribtStr;
}

+(NSAttributedString *)changeWith:(NSString *)string range:(NSRange)range color:(UIColor *)color{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributedStr;
}

+(NSAttributedString *)changeWith:(NSString *)string range:(NSRange)range font:(double)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    return attributedStr;
}
/**
 *  检测麦克风权限，仅支持iOS7.0以上系统
 *
 *  @return 准许返回YES;否则返回NO
 */
+(BOOL)isMicrophonePermissionGranted{
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block BOOL isGranted=YES;
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            isGranted=granted;
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        return isGranted;
    }
    else{
        return YES;
    }
}

/**
 *  检测相机权限
 *
 *  @return 准许返回YES;否则返回NO
 */
+(BOOL)isCapturePermissionGranted{
    if([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]){
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            return NO;
        }
        else if(authStatus==AVAuthorizationStatusNotDetermined){
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            __block BOOL isGranted=YES;
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                isGranted=granted;
                dispatch_semaphore_signal(sema);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            return isGranted;
        }
        else{
            return YES;
        }
    }
    else{
        return YES;
    }
}

///**
// *  检测相册权限
// *
// *  @return 准许返回YES;否则返回NO
// */
//+(BOOL)isAssetsLibraryPermissionGranted{
//    if([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)]){
//        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
//        if (authStatus == ALAuthorizationStatusRestricted || authStatus ==ALAuthorizationStatusDenied){
//            return NO;
//        }
//        else if( authStatus== ALAuthorizationStatusNotDetermined){
//            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//            __block BOOL isGranted=YES;
//
//            dispatch_queue_t dispatchQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            dispatch_async(dispatchQueue, ^(void) {
//                ALAssetsLibrary * assetsLibrary=[[ALAssetsLibrary alloc] init];
//                [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                    isGranted=YES;
//                    *stop = YES;
//                    NSLog(@"enumerate");
//                    dispatch_semaphore_signal(sema);
//                } failureBlock:^(NSError *error) {
//                    isGranted=NO;
//                    NSLog(@"error:%ld %@",(long)error.code,error.description);
//                    dispatch_semaphore_signal(sema);
//                }];
//            });
//            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//            return isGranted;
//        }
//        else{
//            return YES;
//        }
//    }else{
//        return YES;
//    }
//}


@end
