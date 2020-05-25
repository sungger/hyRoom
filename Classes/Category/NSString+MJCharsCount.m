//
//  NSString+MJCharsCount.m
//  GoABroad
//
//  Created by 江波 on 2019/2/26.
//  Copyright © 2019 江波. All rights reserved.
//

#import "NSString+MJCharsCount.h"

@implementation NSString (MJCharsCount)
//得到中英文混合字符串长度 方法1
- (int)convertToInt
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
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
@end
