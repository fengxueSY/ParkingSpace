//
//  Rent_parkCell.m
//  CheWei
//
//  Created by shenyang on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_parkCell.h"

@implementation Rent_parkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellH = WindowHeight / 10;
        _nameLabel = [CreatUI creatLabelWithFrame:CGRectMake(5, 0, WindowWidth / 4, cellH) Text:nil TextFont:16 BackgroudColor:CLEAR_color TextColor:BLACK_color];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}


@end
