//
//  ViewsAnimate.m
//  CheWei
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewsAnimate.h"

@implementation ViewsAnimate
+(void)snowAnimate:(UIView *)showView{
    UIImageView * peach2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snow"]];//声明一个UIImageView对象，用来添加图片
    peach2.alpha = 0.8;//设置该view的alpha为0.5，半透明的
    int xx = round(random()%2000);//随机得到该图片的x坐标
    int yx = round(random()%2000);//这个是该图片移动的最后坐标x轴的
    int sx = random()%50;//这个是定义雪花图片的大小
    int spx = random()%5;//这个是速度
    peach2.frame = CGRectMake(-xx, -10, sx, sx);//雪花开始的大小和位置
    [showView addSubview:peach2];//添加该view
    [UIView animateWithDuration:10*spx
                     animations:^{
                         peach2.frame = CGRectMake(yx, showView.frame.size.height, sx, sx);//设定该雪花最后的消失坐标
                     } completion:^(BOOL finished) {
                         [peach2 removeFromSuperview];
                     }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
