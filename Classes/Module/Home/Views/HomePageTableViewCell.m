//
//  HomePageTableViewCell.m
//  hyRoom
//
//  Created by 江波 on 2020/4/23.
//  Copyright © 2020 hayun. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell
@synthesize title,image,titleLabel,iconView;


-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类init方法创建
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            //创建成功则t给cell添加需要的子视图
            titleLabel = [[UILabel alloc] init];
            [self.contentView addSubview:titleLabel];
            
            iconView = [[UIImageView alloc] init];
            [self.contentView addSubview:iconView];
        }
        
        return self;
}

//重写layoutSubviews方法，给视图设置位置大小
- (void)layoutSubviews{
    iconView.frame = CGRectMake(20, 5, 54, 54);
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 4;
    titleLabel.frame = CGRectMake(80, 5, 100, 30);
}

- (void)setTitle:(NSString *)title{
    titleLabel.text = title;
}

- (void)setImage:(UIImage *)image{
    iconView.image = image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
