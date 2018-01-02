//
//  EditTextCell.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "EditTextCell.h"
#import "ZBTool.h"
@interface EditTextCell()<UITextViewDelegate,UITextFieldDelegate>
{
    //标题
    UILabel *titleLabel;
    //标题内容
    UITextField *titleContentTextField;
    //右侧文字
    UILabel *rightLabel;
    //按钮
    UISwitch *switchView;
    //内容
    UITextView *contenTextView;
    
    
}
@end

@implementation EditTextCell
- (instancetype)init{
    self = [super init];
    if (self) {
        
        titleLabel  = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 10, 60, 25);
        titleLabel.textColor = [SetHexColor colorWithHexString:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        
        titleContentTextField = [[UITextField alloc] init];
        titleContentTextField.frame = CGRectMake(titleLabel.custom_width + 30, 0, kScreenWidth -titleLabel.custom_width -50 , 45);
        titleContentTextField.textColor = [SetHexColor colorWithHexString:@"#757575"];
        titleContentTextField.hidden = YES;
        titleContentTextField.delegate = self;
        titleContentTextField.borderStyle = UITextBorderStyleNone;
        titleContentTextField.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleContentTextField];
        
        rightLabel = [[UILabel alloc] init];
        rightLabel.frame = CGRectMake(kScreenWidth - 190, 0, 160, 45);
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.textColor = [SetHexColor colorWithHexString:@"#757575"];
        rightLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:rightLabel];
        
        switchView = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth - 70, 8.0f, 60.0f, 28.0f)];
        switchView.hidden = YES;
        [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
        [self.contentView addSubview: switchView];
        
        contenTextView = [[UITextView alloc] initWithFrame:CGRectMake(titleLabel.custom_x, titleLabel.custom_botton, kScreenWidth - 20, 60)];
        contenTextView.hidden = YES;
        contenTextView.layer.masksToBounds = YES;
        contenTextView.layer.cornerRadius = 2;
        contenTextView.delegate = self;
        contenTextView.backgroundColor = [SetHexColor colorWithHexString:@"#f8f8f8"];
        contenTextView.textColor = [SetHexColor colorWithHexString:@"#757575"];
        [self.contentView addSubview:contenTextView];

    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.delegate noMoveUpTextField:YES];
}


- (void)recoveryKeyboard{
    [titleContentTextField resignFirstResponder];
    [contenTextView resignFirstResponder];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = _title;
    if ([_title isEqualToString:@"全天"] || [_title isEqualToString:@"重复"]) {
        rightLabel.hidden = YES;
        switchView.hidden = NO;
    }else if ([_title isEqualToString:@"日程内容"]){
        contenTextView.hidden = NO;
        rightLabel.hidden = YES;
   
    }else{
        rightLabel.hidden = NO;
        contenTextView.hidden = YES;
    }
    
   
}


- (void)setTitleContent:(NSString *)titleContent{
    _titleContent = titleContent;
    if (_titleContent && ![_titleContent isEqualToString:@""]) {
        titleContentTextField.text = _titleContent;
        titleContentTextField.hidden = NO;
    }else{
        titleContentTextField.hidden = YES;
    }
}

- (void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    rightLabel.text = _rightText;
    contenTextView.text = _rightText;
}
-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        if ([_title isEqualToString:@"重复"]) {
            NSLog(@"123");
            [self.delegate insertRepeatGroup];
        }
    }else {
        if ([_title isEqualToString:@"重复"]) {
            NSLog(@"123");
            [self.delegate deletRepeatGroup];
        }
        NSLog(@"关");
    }
}
- (void)setIsRepeat:(BOOL)isRepeat{
    _isRepeat = isRepeat;
    [switchView setOn:_isRepeat];
}
- (void)setSignStartTimeSelect:(BOOL)signStartTimeSelect{
    _signStartTimeSelect = signStartTimeSelect;
    if (_signStartTimeSelect == NO) {
        rightLabel.textColor = [UIColor redColor];
    }else{
        rightLabel.textColor = [SetHexColor colorWithHexString:@"#757575"];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self recoveryKeyboard];
        return NO;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self recoveryKeyboard];
    return YES;
}
@end
