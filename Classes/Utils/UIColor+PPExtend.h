//
//  UIColor+PPExtend.h
//

#import <UIKit/UIKit.h>

@interface UIColor (PPExtend)

/**
 *  根据
 *
 *  @param hexValue   <#hexValue description#>
 *  @param alphaValue <#alphaValue description#>
 *
 *  @return <#return value description#>
 *
 *  @exception <#exception description#>
 */
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
/**
 *  UIColor 转UIimage
 *
 *  @param color 转换的颜色
 *
 *  @return image
 */
+ (UIImage*) createImageWithColor: (UIColor*) color;

/**
 *  str 转UIimage
 *
 *  @param colorStr 颜色的字符串
 *
 *  @return image
 */
+ (UIImage*) createImageWithColorStr: (NSString*) colorStr;

/**
 *  通过字符串跟透明度创建颜色
 *
 *  
 */
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alph;

@end
