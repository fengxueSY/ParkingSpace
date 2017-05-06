//
//  CellPersonal.m
//  CheWei
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CellPersonal.h"

@implementation CellPersonal
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        float height = WindowHeight / 10;
        self.titileLable = [[UILabel alloc]init];
        self.titileLable.frame = CGRectMake(WindowWidth / 32, height / 4, WindowWidth / 4 + WindowWidth / 32, height / 2);
        self.titileLable.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.titileLable];
        
        self.dataLabel = [[UILabel alloc]init];
        CGRect f1 = self.titileLable.frame;
        f1.origin.x = Max_X(self.titileLable);
        f1.size.width = WindowWidth / 2;
        self.dataLabel.frame = f1;
        self.dataLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dataLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
