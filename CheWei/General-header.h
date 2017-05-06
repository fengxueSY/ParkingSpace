//
//  General-header.h
//  CheWei
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef General_header_h
#define General_header_h
//隐藏返回按钮的文字提示
#define BackTitle_hidden [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:NULL];
//一些常量
#define barHeight64 64
#define barHeight44 44
#define tabBarHeight49 49

#define RGBcolor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define CLEAR_color [UIColor clearColor]
#define WHITE_color [UIColor whiteColor]
#define BLACK_color [UIColor blackColor]
#define GRAY_color [UIColor grayColor]
#define LightGRAY_color [UIColor lightGrayColor]
#define ORANGE_color [UIColor orangeColor]
#define FONT_size(x) [UIFont systemFontOfSize:x]
//
#define Min_X(view) CGRectGetMinX(view.frame)
#define Max_X(view) CGRectGetMaxX(view.frame)
#define Min_Y(view) CGRectGetMinY(view.frame)
#define Max_Y(view) CGRectGetMaxY(view.frame)
#define View_Width(view) CGRectGetWidth(view.frame)
#define View_Height(view) CGRectGetHeight(view.frame)

#define Equarl_String(x,y) [x isEqualToString:y]
#define Equarl_stringCode0(x) [x isEqualToString:@"0"]
#define Format_String(x) [NSString stringWithFormat:@"%@",x]
#define NSUInteger_String(x) [NSString stringWithFormat:@"%lu",(unsigned long)x]
#define Stitch_String(a,b) [NSString stringWithFormat:@"%@%@",a,b]
#define ImageNamed(x) [UIImage imageNamed:x]
#define USER_Default [NSUserDefaults standardUserDefaults]

//打印
#ifndef DEBUG
#  define NSLog(...)
#endif
#ifndef __OPTIMIZE__
#define NSLog(FORMAT,...)   NSLog(@"%@文件%d行输出打印:%@",[[[NSString stringWithFormat:@"%s",__FILE__] componentsSeparatedByString:@"/"] lastObject], __LINE__,[NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define NSLog(...) {}
#endif
#define  L1(x)       NSLog(@"%@",x)
#define  L2(x,y)      NSLog(@"%@ -- %@",x,y)
#define  N1(x)       NSLog(@"%ld",x)
#define  F1(x)       NSLog(@"%f",x)
#endif /* General_header_h */
