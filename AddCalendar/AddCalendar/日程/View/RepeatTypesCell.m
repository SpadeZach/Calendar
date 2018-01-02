//
//  RepeatTypesCell.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/26.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "RepeatTypesCell.h"
#import "ZBTool.h"
@interface RepeatTypesCell(){
    UIImageView *imgView;
    UILabel *titleLabel;
}
@end
@implementation RepeatTypesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imgView= [[UIImageView alloc] init];
        imgView.frame = CGRectMake(15, 12, 20, 20);
    
        [self.contentView addSubview:imgView];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth - 65, 44)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [SetHexColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:titleLabel];
    }
    
    return self;
}
- (void)setIfSelected:(BOOL)ifSelected{
    _ifSelected = ifSelected;
    if (_ifSelected) {
        imgView.image = [UIImage imageNamed:@"SchedueChoose"];
    }else{
        imgView.image = [UIImage imageNamed:@"NotChoose"];
    }
}
- (void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = _title;
}
@end
