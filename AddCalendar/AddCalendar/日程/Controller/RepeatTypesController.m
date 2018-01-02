//
//  RepeatTypesController.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/26.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "RepeatTypesController.h"
#import "ZBTool.h"
#import "RepeatTypesCell.h"
@interface RepeatTypesController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
//是否选中
@property (nonatomic, assign)BOOL ifSelected;
//上一次选中的索引
@property (nonatomic, strong)NSIndexPath * lastSelected;
@end

@implementation RepeatTypesController
static NSString *const tableCellIndetify = @"RepeatTypesControllerCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.navTitle;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [SetHexColor colorWithHexString:@"#f8f8f8"];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.ifSelected = NO;
}
- (void)setTitleArry:(NSArray *)titleArry{
    _titleArry = titleArry;
}
- (void)setChooseType:(NSInteger)chooseType{
    _chooseType = chooseType;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *path = [NSIndexPath indexPathForRow:_chooseType inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:path];
    });
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepeatTypesCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIndetify];
    if (!cell) {
        cell = [[RepeatTypesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIndetify];
       
    }
    cell.ifSelected = self.ifSelected;
    cell.title = self.titleArry[indexPath.row];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * temp = self.lastSelected;//暂存上一次选中的行
    //如果上一次的选中的行存在,并且不是当前选中的这一行,则让上一行不选中
    if (temp && temp != indexPath) {
        self.ifSelected = NO;//修改之前选中的cell的数据为不选中
        [tableView reloadRowsAtIndexPaths:@[temp] withRowAnimation:UITableViewRowAnimationAutomatic];//刷新该行
    }
    self.lastSelected = indexPath;//选中的修改为当前行
    self.ifSelected = YES;//修改这个被选中的一行
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//重新刷新
}

- (void)viewWillDisappear:(BOOL)animated{
    __weak typeof(self) weakSelf = self;
    if (weakSelf.block) {
        weakSelf.block(self.titleArry[self.lastSelected.row]);
    }
}

@end
