//
//  SearchResultCell.m
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellW = WindowWidth;
        float cellH = WindowHeight / 10;
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(cellW / 64, 0, cellW / 4, cellH);
        _nameLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
        [self.contentView addSubview:_nameLabel];
        
        _conLabel = [[UILabel alloc]init];
        _conLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, cellW, cellH);
        _conLabel.numberOfLines = 0;
        _conLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
        [self.contentView addSubview:_conLabel];
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
