//
//  BaseTabController.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/4/6.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "BaseTabC.h"

@interface BaseTabC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTabC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   
}


-(void)configWithTable:(void(^)(UITableView *tabl))initTabl
          withSections:(NSInteger(^)())sections
     withSectionsInRow:(NSInteger(^)(NSInteger section))rows
      withHeightForRow:(float(^)(NSIndexPath *indexPath))heightForRow
          withLoadCell:(UITableViewCell*(^)(NSIndexPath *indexPath))cell
         withSelectRow:(void(^)(NSIndexPath *indexPath))tap{
    
    self.didSelectRow = tap;
    self.sections = sections;
    self.sectionInRows = rows;
    self.heightForRow = heightForRow;
    self.cell = cell;
    
    //创建表
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    [self.baseTableView setDelegate:self];
    [self.baseTableView setDataSource:self];
    [self.view setBackgroundColor:RGB(237, 239, 239)];
    
    //回调过去
    initTabl(self.baseTableView);
    [self.view addSubview:self.baseTableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 20;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections();
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sectionInRows(section);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.heightForRow(indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cell(indexPath);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelectRow(indexPath);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
