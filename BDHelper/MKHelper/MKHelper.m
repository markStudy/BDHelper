//
//  Helper.m
//  PalmKitchen
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MKHelper.h"

@implementation MKHelper

+ (void)limitWordLength:(UITextField *)textField maxLength:(NSInteger)length limitBlock:(void (^)())limitBlock {
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];

    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        if (!position) { // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > length) {
                [textField deleteBackward];

                if (limitBlock) {
                    limitBlock();
                }
            }
        } else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > length) {
            [textField deleteBackward];
            
            if (limitBlock) {
                limitBlock();
            }
        }
    }
}



#pragma mark - 计算文本的高和宽
+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height {
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

#pragma mark - 校验
//邮箱
+ (BOOL) justEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) justCarType:(NSString *)CarType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) justUserName:(NSString *)name {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) justPassword:(NSString *)passWord {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//登陆密码校验 （6）
+ (BOOL) justLoginPassword:(NSString *)passWord {
    NSString *passWordRegex = @"^\\w{6,12}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//新密码规则校验（6-）
+ (BOOL) justNewPassword:(NSString *)passWord {
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}



//昵称
+ (BOOL) justNickname:(NSString *)nickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5a-zA-Z0-9]{4,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}




@end




@implementation MKDateHelper

#pragma mark - 时间转换
/**
 *  时间戳转换为时间的方法
 *  @param timestamp 时间戳
 *  @return 标准时间字符串
 */
+ (NSString *)timestampChangesStandarTime:(NSString *)timestamp dateFormatter:(NSString *)formatter {
    
    if (formatter.length == 0) {
        formatter = minFormatter;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:formatter];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
    
}

/** 通过字符串获取NSDate */
+ (NSDate *)getDateFromString:(NSString *)date dateFormatter:(NSString *)formatter {
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:formatter];
    NSDate *fromdate=[format dateFromString:date];
    
    //得到本地时间，避免时区问题
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:fromdate];
    NSDate *localeDate = [fromdate dateByAddingTimeInterval:interval];
    
    return localeDate;
}

/** 通过date获取日期字符串 */
+ (NSString *)getStringFromDate:(NSDate *)date dateFormatter:(NSString *)formatter {
    
    // 再将日期格式转换成需要的格式
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    //    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:formatter];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"GMT"];
    [outputFormatter setTimeZone:zone];
    NSString *currentDate = [outputFormatter stringFromDate:date];
    return currentDate;
}

/**
 * 时间转换星期
 * time 2015-02-03
 *  formatter (为nil默认minFormatter）
 */
+ (NSString *)timeToweek:(NSString *)time dateFormatter:(NSString *)formatter {
    if (formatter.length == 0) {
        formatter = minFormatter;
    }
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:formatter];
    NSDate *formatterDate = [inputFormatter dateFromString:time];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    return newDateString;
}


#pragma mark - 获取时间日期
/**
 *  获取当前时间的时间戳（例子：1464326536）
 *  @return 时间戳字符串型(秒级)
 */
+ (NSString *)getCurrentTimestamp {
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    // 转为字符型
    return timeString;
}

// 获取今天的日期
+ (NSDate *)getCurrentDate {
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}


//获取今天的日期
+ (NSDictionary *)getTodayDate {
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%zd", [components year]];
    NSString *month = [NSString stringWithFormat:@"%02zd", [components month]];
    NSString *day = [NSString stringWithFormat:@"%02zd", [components day]];
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    
    return todayDic;
}

//获取今天的时间
+ (NSString *)getCurrentTime {
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSHourCalendarUnit|NSMinuteCalendarUnit;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *hour = [NSString stringWithFormat:@"%02zd", [components hour]];
    NSString *minute = [NSString stringWithFormat:@"%02zd", [components minute]];
    
    NSString *time = [NSString stringWithFormat:@"%@:%@",hour,minute];
    return time;
}



#pragma  mark - 时间比较、判断
+ (NSDictionary *)compareFromDate:(NSDate *)from toDate:(NSDate *)to {
    
    if (!to || !from) {
        return @{};
    }
    
    // 日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    // 时间片段 ：年  月  日  时 分 秒
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents * com = [calendar components:unit fromDate:from toDate:to options:0];
    
    //    NSString *string = [NSString stringWithFormat:@"%ld天%ld小时%ld分钟", com.day, com.hour, com.minute];
    
    NSDictionary *dict = @{@"year":@(com.year),@"month":@(com.month),@"day":@(com.day),@"hour":@(com.hour),@"min":@(com.minute)};
    
    return dict;
}


// 判断日期是今天，昨天还是明天
+ (NSString *)compareDate:(NSDate *)date {
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString]) {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString]) {
        return @"昨天";
    } else if ([dateString isEqualToString:tomorrowString]){
        return @"明天";
    } else {
        return dateString;
    }
}


@end


#import "sys/utsname.h"
#import <UIKit/UIKit.h>

@implementation MKDeviceInfoHelper

struct utsname systemInfo;

+ (NSString *)phoneModels {
    return [self iphoneType];
}

+ (NSString *)phoneSystemVersion{
    return [NSString stringWithFormat:@"iOS %@", [[UIDevice currentDevice] systemVersion]];
}


+ (NSString *)iphoneType {
    
    // 需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}


@end









