//
//  EditScheduleController.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "EditScheduleController.h"
#import "ZBTool.h"
#import "EditTextCell.h"
#import "EditSchedulePickerCell.h"
#import "RepeatTypesController.h"
#import "SecheduleModel.h"
#define StartTimeIndex 1
#define EndTimeIndex 2
@interface EditScheduleController ()<UITableViewDelegate,UITableViewDataSource,EditSchedulePickerCellDelegate,EditTextCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *titleArr;
@property(nonatomic, strong)NSMutableArray *rightArr;
//标记开始时间是否点击
@property(nonatomic, assign)BOOL signStartTimeSelect;
//标记结束时间是否点击
@property(nonatomic, assign)BOOL signEndTimeSelect;
//标记点击时间的那行
@property(nonatomic, strong)NSIndexPath *signTimeIndex;
@property(nonatomic, assign)BOOL signTimeSelect;
@property(nonatomic, assign)BOOL isTextFieldAppear;
@end
static NSString *const tableCellIndetify = @"EditScheduleCell";
@implementation EditScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self keyBoardResponse];
   
    self.titleArr = @[@[@"主题"].mutableCopy,@[@"开始",@"结束",@"全天",@"重复"].mutableCopy,@[@"定时提醒",@"事件类型",@"日程内容"].mutableCopy,@[@"参与人员"].mutableCopy,@[@"执行人"].mutableCopy].mutableCopy;
     self.rightArr = @[@[@"测试"].mutableCopy,@[@"2017-12-25 15:30",@"2018-01-01 15:30",@"全天",@"重复"].mutableCopy,@[@"准时",@"其他",@"内容内容"].mutableCopy,@[@"1"].mutableCopy,@[@"2"].mutableCopy].mutableCopy;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.signStartTimeSelect = YES;
    self.signEndTimeSelect = YES;
}
- (void)setSechedModel:(SecheduleModel *)sechedModel{
    _sechedModel = sechedModel;
    
    
   
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arry = self.titleArr[section];
    return arry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *firstArr = self.titleArr[1];
    if ([firstArr containsObject:@"开始选择器"] ||[firstArr containsObject:@"结束选择器"]){
        NSInteger index = [firstArr indexOfObject:@"开始选择器"];
        NSInteger index2=  [firstArr indexOfObject:@"结束选择器"];
        if ((indexPath.section == 1 && indexPath.row == index) ||(indexPath.section == 1 && indexPath.row == index2)) {
            return 120;
        }else{
            if (indexPath.section == self.titleArr.count - 3 && indexPath.row == 2) {
                return 110;
            }else{
                  return 45;
            }
            
          
        }
    }else{
        if (indexPath.section == self.titleArr.count - 3 && indexPath.row == 2) {
            return 110;
        }else{
            return 45;
        }
    }
    
    
}




#pragma mark - 重用池
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *firstArr = self.titleArr[indexPath.section];
    
    if ([firstArr containsObject:@"开始选择器"] || [firstArr containsObject:@"结束选择器"]) {
        NSInteger index = [firstArr indexOfObject:@"开始选择器"];
        NSInteger index2=  [firstArr indexOfObject:@"结束选择器"];
        if ((indexPath.section == 1 && indexPath.row == index) ||(indexPath.section == 1 && indexPath.row == index2)) {
            EditSchedulePickerCell *cell = [[EditSchedulePickerCell alloc] init];
            cell.delegate = self;
            return cell;
        }else{
            EditTextCell *cell = [[EditTextCell alloc] init];
            cell.title = self.titleArr[indexPath.section][indexPath.row];
            
            if (indexPath.section == 0) {
                cell.titleContent = self.rightArr[0][0];
            }else{
                cell.rightText = self.rightArr[indexPath.section][indexPath.row];
            }
            
            if (indexPath.section > 1){
                if (indexPath.section == 2 && indexPath.row == 2) {
                    NSLog(@"123123123");
                }else{
                    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
                }
                
            }
            
            cell.delegate = self;
            return cell;
        }
        
    }else{
        EditTextCell *cell = [[EditTextCell alloc] init];
        cell.title = self.titleArr[indexPath.section][indexPath.row];
        if (indexPath.section == 0) {
            cell.titleContent = self.rightArr[0][0];
        }else{
            cell.rightText = self.rightArr[indexPath.section][indexPath.row];
        }
        if (indexPath.section > 1){
            if (indexPath.section == 2 && indexPath.row == 2) {
                NSLog(@"123123123");
            }else{
                cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
        cell.delegate = self;
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =  [UIView new];
    view.backgroundColor = [UIColor colorWithRed:246.0 / 255.0 green:246.0 / 255.0 blue:246.0 / 255.0 alpha:1];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self performSelector:@selector(deselectRow) withObject:nil afterDelay:0.1];
     if (indexPath.section == self.titleArr.count - 3 && indexPath.row == 2) {
         
         return;
     }else if (indexPath.section > 1){
        if ([self.titleArr[indexPath.section][indexPath.row] isEqualToString:@"重复类型"]) {
            [self repeatPushView:tableView didSelectRowAtIndexPath:indexPath repeatArr:@[@"每天重复",@"每周重复",@"每月重复",@"每年重复"]];
        }else if ([self.titleArr[indexPath.section][indexPath.row] isEqualToString:@"结束条件"]){
            [self repeatPushView:tableView didSelectRowAtIndexPath:indexPath repeatArr:@[@"永不结束",@"结束日期"]];
        }else if ([self.titleArr[indexPath.section][indexPath.row] isEqualToString:@"定时提醒"]){
            [self repeatPushView:tableView didSelectRowAtIndexPath:indexPath repeatArr:@[@"不提醒",@"准时",@"提前10分钟",@"提前30分钟",@"提前1小时",@"提前2小时",@"提前6小时",@"提前1天"]];
        }else if ([self.titleArr[indexPath.section][indexPath.row] isEqualToString:@"事件类型"]){
            [self repeatPushView:tableView didSelectRowAtIndexPath:indexPath repeatArr:@[@"会议",@"拜访客户",@"其他",@"行程安排"]];
        }else if ([self.titleArr[indexPath.section][indexPath.row]isEqualToString:@"日程内容"]){
        }
         
         return;
     }
    [self signEndTimeSelect:tableView indexPath:indexPath];
    
}

#pragma mark - 键盘通知
- (void)keyBoardResponse{

    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)noMoveUpTextField:(BOOL)isAppear{
    self.isTextFieldAppear = isAppear;
}
//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    if (!self.isTextFieldAppear) {
        [UIView animateWithDuration:1 animations:^{
            self.view.frame = CGRectMake(0, -height, self.view.custom_width, self.view.custom_height);
        }];
        
    }
    
}


///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    self.isTextFieldAppear = NO;
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    EditTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell recoveryKeyboard];
    
    EditTextCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:self.titleArr.count - 3]];
    [cell1 recoveryKeyboard];
}
#pragma mark - table选中效果
- (void)deselectRow{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


#pragma mark - 处理点击开始/结束时间增删选择器cell
- (void)signEndTimeSelect:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    NSString *tempStr = self.titleArr[indexPath.section][indexPath.row];
    NSMutableArray *tempArr = self.titleArr[indexPath.section];
    NSMutableArray *tempRight = self.rightArr[indexPath.section];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger atRow = indexPath.row + 1;
    NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:atRow inSection:indexPath.section];
    [indexPaths addObject: tempIndexPath];
    if ([tempStr isEqualToString:@"开始"]) {
        self.signTimeIndex = indexPath;
        if (self.signStartTimeSelect) {
            if ([tempArr containsObject:@"结束选择器"]) {
                NSIndexPath *delePath = [NSIndexPath indexPathForRow:EndTimeIndex inSection:1];
                [tempArr removeObjectAtIndex:EndTimeIndex];
                [tempRight removeObjectAtIndex:EndTimeIndex];
                [self.tableView deleteRowsAtIndexPaths:@[delePath].mutableCopy withRowAnimation:UITableViewRowAnimationTop];
                 self.signEndTimeSelect = YES;
                EditTextCell *cell = [tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:StartTimeIndex inSection:1]];
                cell.signStartTimeSelect = YES;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tempArr insertObject:@"开始选择器" atIndex:atRow];
                [tempRight insertObject:@"开始选择器" atIndex:atRow];
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                self.signStartTimeSelect = NO;
                EditTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.signStartTimeSelect = self.signStartTimeSelect;
            });
           
        }else{
            [tempArr removeObject:@"开始选择器"];
            [tempRight removeObject:@"开始选择器"];
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            self.signStartTimeSelect = YES;
            EditTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.signStartTimeSelect = self.signStartTimeSelect;
            self.signTimeIndex = nil;
            
        }
        
    }else if ([tempStr isEqualToString:@"结束"]){
        self.signTimeIndex = indexPath;
        self.signTimeIndex = indexPath;
        if (self.signEndTimeSelect) {
            
            if ([tempArr containsObject:@"开始选择器"]) {
                NSIndexPath *delePath = [NSIndexPath indexPathForRow:1 inSection:1];
                [tempArr removeObjectAtIndex:1];
                [tempRight removeObjectAtIndex:1];
                [self.tableView deleteRowsAtIndexPaths:@[delePath].mutableCopy withRowAnimation:UITableViewRowAnimationTop];
                self.signStartTimeSelect = YES;
                EditTextCell *cell = [tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:1]];
                cell.signStartTimeSelect = YES;
                
                indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                atRow = 1;

                indexPaths = @[[NSIndexPath indexPathForRow:2 inSection:1]].mutableCopy;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tempArr insertObject:@"结束选择器" atIndex:2];
                [tempRight insertObject:@"结束选择器" atIndex:2];
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                self.signEndTimeSelect = NO;
                EditTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.signStartTimeSelect = NO;
                
            });
           
            
        }else{
            [tempArr removeObject:@"结束选择器"];
            [tempRight removeObject:@"结束选择器"];
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            self.signEndTimeSelect = YES;
            EditTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.signStartTimeSelect = self.signEndTimeSelect;
            self.signTimeIndex = nil;
            
        }
       
    }
    
    
}
#pragma mark - 时间选择器
- (void)reloadPickerViewDates:(NSString *)dateStr{
    NSMutableArray *tempArr = self.rightArr[self.signTimeIndex.section];
    [tempArr replaceObjectAtIndex:self.signTimeIndex.row withObject:dateStr];
    EditTextCell *cell = [self.tableView cellForRowAtIndexPath:self.signTimeIndex];
    cell.rightText = self.rightArr[self.signTimeIndex.section][self.signTimeIndex.row];
}
#pragma mark - 添加重复组
- (void)insertRepeatGroup{
    if (self.signTimeIndex) {
        [self signEndTimeSelect:self.tableView indexPath:self.signTimeIndex];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.titleArr insertObject:@[@"重复类型",@"结束条件"].mutableCopy atIndex:2];
        [self.rightArr insertObject:@[@"每周重复",@"永不结束"].mutableCopy atIndex:2];
        [self.tableView reloadData];
        EditTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
        cell.isRepeat = YES;
    });
}
#pragma mark - 删除重复组
- (void)deletRepeatGroup{
    
    if (self.signTimeIndex) {
        [self signEndTimeSelect:self.tableView indexPath:self.signTimeIndex];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *repeatArr = self.titleArr[2];
        if ([repeatArr containsObject:@"重复类型"]) {
            [self.titleArr removeObjectAtIndex:2];
            [self.rightArr removeObjectAtIndex:2];
        }
        [self.tableView reloadData];
        for (int i = 2; i < self.rightArr.count; i++) {
            NSMutableArray *tempArr = self.rightArr[i];
            for (int j = 0; j < tempArr.count; j++) {
                EditTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                cell.rightText = self.rightArr[i][j];
                cell.title = self.titleArr[i][j];
            }
            
        }
    });
    
}


#pragma mark - 跳转事件
- (void)repeatPushView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath repeatArr:(NSArray *)repeatArr{
    RepeatTypesController *repeatTypes = [[RepeatTypesController alloc] init];
 
    repeatTypes.titleArry = repeatArr;
    NSMutableArray *tempArr = self.rightArr[indexPath.section];
    NSInteger chooseType = 0;
    for (NSInteger i = 0; i < repeatArr.count; i++) {
        if ([tempArr[indexPath.row] isEqualToString:repeatArr[i]]) {
            chooseType = i;
        }
    }
    repeatTypes.navTitle = self.titleArr[indexPath.section][indexPath.row];
    repeatTypes.chooseType = chooseType;
    repeatTypes.block = ^(NSString *typeStr) {
        [tempArr replaceObjectAtIndex:0 withObject:typeStr];
        EditTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.rightText = typeStr;
    };
    [self.navigationController pushViewController:repeatTypes animated:YES];
}
@end
