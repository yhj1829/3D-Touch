//
//  NSString+XCString.m
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "NSString+XCString.h"

@implementation NSString (XCString)

#pragma mark - Private API
+ (BOOL)isNumber:(char)ch
{
    if(!(ch >= '0' && ch <= '9')) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isValidNumber:(NSString *)value
{
    const char *cvalue = [value UTF8String];
    unsigned long len = strlen(cvalue);
    for(unsigned long i = 0; i < len; i++) {
        if(![NSString isNumber:cvalue[i]]) {
            return NO;
        }
    }
    return TRUE;
}

#pragma mark - Public API
-(int)checkIsHaveNumAndLetter
{
    NSRegularExpression *numRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numMatchCount = [numRegularExpression numberOfMatchesInString:self
                                                                     options:NSMatchingReportProgress
                                                                       range:NSMakeRange(0, self.length)];
    
    NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    if (numMatchCount == self.length) {
        return 1;
    } else if (letterMatchCount == self.length) {
        return 2;
    } else if (numMatchCount + letterMatchCount == self.length) {
        return 3;
    } else {
        return 4;
    }
}

- (NSString *)privacyPhone
{
    if(11 != self.length) {
        return self;
    }
    
    return [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(4, 4)] withString:@"****"];
}

- (BOOL)isQQ
{
    return self.length >= 5 && [NSString isValidNumber:self];
}

- (BOOL)isBirthday
{
    BOOL result = FALSE;
    if(self && 8 == [self length]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *date = [formatter dateFromString:self];
        if(date) {
            result = TRUE;
        }
    }
    
    return result;
}

- (BOOL)isPhone
{
    return [self hasPrefix:@"1"] && self.length == 11;
    
    /*
     *  因为以下逻辑不包含170...号段，所以无用了
     *
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     
     NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
     NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
     if([regextestcu evaluateWithObject:self]) {
     return YES;
     } else {
     return NO;
     }
     
     */
}

- (BOOL)isEmail {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

+ (BOOL)isEmail:(NSString *)email {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

- (CGSize)xc_findHeightForHavingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if(self) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

@end
