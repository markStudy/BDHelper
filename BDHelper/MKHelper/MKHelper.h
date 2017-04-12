//
//  Helper.h
//  PalmKitchen
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKHelper : NSObject

+ (void)limitWordLength:(UITextField *)textField maxLength:(NSInteger)length limitBlock:(void (^)())limitBlock;

//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

//邮箱
+ (BOOL) justEmail:(NSString *)email;

//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo;

//车型
+ (BOOL) justCarType:(NSString *)CarType;

//用户名
+ (BOOL) justUserName:(NSString *)name;

//密码
+ (BOOL) justPassword:(NSString *)passWord;

//登陆密码校验
+ (BOOL) justLoginPassword:(NSString *)passWord;

//新密码规则校验
+ (BOOL) justNewPassword:(NSString *)passWord;

//昵称
+ (BOOL) justNickname:(NSString *)nickname;

//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard;


@end



static NSString *const minFormatter = @"yyyy-MM-dd HH:mm";
static NSString *const secondFormatter = @"yyyy-MM-dd HH:mm:ss";

@interface MKDateHelper : NSObject

#pragma mark - 时间转换
/**
 *  时间戳转换为时间的方法
 *  @param timestamp 时间戳
 *  @return 标准时间字符串
 */
+ (NSString *)timestampChangesStandarTime:(NSString *)timestamp dateFormatter:(NSString *)formatter;

/** 通过字符串获取NSDate */
+ (NSDate *)getDateFromString:(NSString *)date dateFormatter:(NSString *)formatter;

/** 通过date获取日期字符串 */
+ (NSString *)getStringFromDate:(NSDate *)date dateFormatter:(NSString *)formatter;

/**
 * 时间转换星期
 * time 2015-02-03
 *  formatter (为nil默认minFormatter）
 */
+ (NSString *)timeToweek:(NSString *)time dateFormatter:(NSString *)formatter ;

#pragma mark - 获取时间日期
/**
 *  获取当前时间的时间戳（例子：1464326536）
 *  @return 时间戳字符串型(秒级)
 */
+ (NSString *)getCurrentTimestamp;

// 获取今天的日期
+ (NSDate *)getCurrentDate;

//获取今天的日期
+ (NSDictionary *)getTodayDate;

//获取今天的时间
+ (NSString *)getCurrentTime;

#pragma  mark - 时间比较、判断
+ (NSDictionary *)compareFromDate:(NSDate *)from toDate:(NSDate *)to;

// 判断日期是今天，昨天还是明天
+ (NSString *)compareDate:(NSDate *)date;

@end



@interface MKDeviceInfoHelper : NSObject

/** 手机型号 */
+ (NSString *)phoneModels;

/** 手机系统 */
+ (NSString *)phoneSystemVersion;

@end





