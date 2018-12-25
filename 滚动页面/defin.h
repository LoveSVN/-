//
//  RunBaby-PrefixHeader.pch
//  RunBaby
//
//  Created by huangjingjin on 16/9/20.
//  Copyright © 2016年 狂奔的小马达. All rights reserved.
//

#ifndef RunBaby_PrefixHeader_pch
#define RunBaby_PrefixHeader_pch


//****************************系统配置****************************
//系统导航
#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//系统字体
#define Font(S) [UIFont fontWithName:PFR size:S]
#define BoldFont(S) [UIFont boldSystemFontOfSize:S]
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

//快速照片
#define Image(image)  [UIImage imageNamed:image]
//快速本地图片
#define ContentsImage(image,type)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:image ofType:type]]
//快速原图片
#define OriginalImage(image) [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//支付宝回调
#define AlipaySuccess @"AlipaySuccess"
//加载中的图片
#define LoadingImage  [UIImage imageNamed:@"Loading_Horizontal"]
#define LoadingHorizontalImage  [UIImage imageNamed:@"Loading_Horizontal"]
#define LoadingVerticalImage  [UIImage imageNamed:@"Loading_Vertical"]
#define LoadingSquareImage  [UIImage imageNamed:@"Loading_Square"]
//快速字符串
#define QuickNSString(str1,str2)      [NSString stringWithFormat:str1,str2]
//快速连接
#define URL(U) [NSURL URLWithString:U]
//快速字符串
#define NSStringFormat(str1,str2)      [NSString stringWithFormat:str1,str2]
//弱引用
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define  WC __unsafe_unretained typeof(self) weakSelf = self


//============================颜色================================
//总色调
#define BaseColor  RGB_X(0x151826)
//总色调
#define BntBgColor  RGB(68, 68, 68, 1)
//色调
#define BaseLineColor  RGB(237, 197, 146, 1)


//系统背景颜色
#define kSystemBgColor RGB(242, 242, 242, 1)
//标题文字及一些重要文字颜色
#define kTitleColor RGB_X(0x363636)

//配色
#define GrayColor RGB(195, 195, 195, 1)
#define RedColor RGB(238, 78, 80, 1)
#define BlueColor RGB(91, 168, 223, 1)
#define GreenColor RGB(75, 168, 101, 1)
#define OraOngeColor RGB(240, 110, 0, 1)
//弱色
#define YellowColor RGB(251, 203, 127, 1)
#define LightBlueColor RGB(159, 200, 228, 1)
#define DarkColor RGB(97, 98, 122, 1)

#define ColorLine   RGB_X(0xe1e1e1)//用于全部线条
#define Color333    RGB_X(0x333333)//用于文字
#define Color999    RGB_X(0x999999)//用于文字
#define Color666    RGB_X(0x666666)//用于文字
#define ColorFFF    RGB_X(0xFFFFFF)//用于文字
#define ColorBA     RGB_X(0xbababa)//用于部分提示文字
#define ColorGray   RGB_X(0xc5cbd8)//用于按钮置灰
#define ColorBlue   RGB_X(0x4f74c0)//用于部分蓝色文字
#define ColorRed    RGB_X(0xff593e)//用于部分红色文字
#define ColorYel    RGB_X(0xFFE324)//用于部分黄色色文字
#define ColorFed    RGB_X(0xff0079)//用于部分红色文字
#define ColorItem   RGB_X(0x2D2F3A)//用于文字

//颜色
#define RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a/1.0f]
//颜色  RGB_X(0x067AB5)
#define RGB_X(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//***************************版本配置***************************
//判断版本
#define Version                          [[UIDevice currentDevice] systemVersion]
#define VersionMoreiOS7         [Version floatValue]>=7.0
#define VersionMoreiOS8         [Version floatValue]>=8.0
#define VersionMoreiOS9         [Version floatValue]>=9.0
#define VersionMoreiOS10       [Version floatValue]>=10.0
#define VersionMoreiOS11        [Version floatValue]>=11.0

#define iOS11               ([Version floatValue]>=11.0)&&([Version floatValue]<12.0)//@available(iOS 11.0, *)
#define iOS10               ([Version floatValue]>=10.0)&&([Version floatValue]<11.0)
#define iOS9               ([Version floatValue]>=9.0)&&([Version floatValue]<10.0)
#define iOS8               ([Version floatValue]>=8.0)&&([Version floatValue]<9.0)
#define iOS7                ([Version floatValue]>=7.0)&&([Version floatValue]<8.0)

//屏幕长度
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
//列表高低度
#define TabHeight 8.0f
/**
 *  属性转字符串
 */
#define CCKeyPath(obj, key) @(((void)obj.key, #key))
//系统Nav高度
#define NavHeight    (DistanceTop+44)
#define TaBarHeight    (isIphoneX?(83.0):(49.0))
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
//配置高度
#define DistanceTop  (isIphoneX?40:20)



#define isIphoneX [[NSString jj_getCurrentDevice] containsString:@"X"]

//是否是空对象
#define CCIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[函数名:%s]\n" "[行号:%d] \n" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

//************************输出日志************************
#ifdef DEBUG
#define JJLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define JJLog(format, ...)
#endif

#endif

