//
//  HomePageTableViewCell.h
//  hyRoom
//
//  Created by 江波 on 2020/4/23.
//  Copyright © 2020 hayun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageTableViewCell : UITableViewCell
//声明两个属性，用于给视图赋值
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)UIImage *image;
//声明两个视图
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *iconView;
@end

NS_ASSUME_NONNULL_END
