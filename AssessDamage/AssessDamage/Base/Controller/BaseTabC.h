//
//  BaseTabController.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/4/6.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "BaseC.h"

@interface BaseTabC : BaseC

@property(nonatomic,strong)UITableView *baseTableView;
 
@property(nonatomic,strong)NSInteger(^sections)();
@property(nonatomic,strong)NSInteger(^sectionInRows)(NSInteger section);
@property(nonatomic,strong)float(^heightForRow)(NSIndexPath *indexPath);
@property(nonatomic,strong)void(^didSelectRow)(NSIndexPath *indexPath);
@property(nonatomic,strong)UITableViewCell*(^cell)(NSIndexPath *indexPath);
 
-(void)configWithTable:(void(^)(UITableView *tabl))initTabl
          withSections:(NSInteger(^)())sections
     withSectionsInRow:(NSInteger(^)(NSInteger section))rows
      withHeightForRow:(float(^)(NSIndexPath *indexPath))heightForRow
          withLoadCell:(UITableViewCell*(^)(NSIndexPath *indexPath))cell
         withSelectRow:(void(^)(NSIndexPath *indexPath))tap;


@end
