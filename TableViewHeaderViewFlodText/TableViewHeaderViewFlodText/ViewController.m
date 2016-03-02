//
//  ViewController.m
//  TableViewHeaderViewFlodText
//
//  Created by 刘光军 on 15/12/14.
//  Copyright © 2015年 刘光军. All rights reserved.
//

#import "ViewController.h"
#import "LGJFoldHeaderView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, FoldSectionHeaderViewDelegate>

@property(nonatomic, strong) UITableView* tableView;/**< tableview */
@property(nonatomic, strong) NSArray* arr;/**< 数组 */
@property(nonatomic, strong) NSDictionary* foldInfoDic;/**< 存储开关字典 */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatArr];
    [self creatTableView];
    

}

- (void)creatArr {
    _arr = @[@"123445",@"12412421",@"3243243",@"12313",@"324324",@"132311",@"3423",@"3423432"];
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"1",
                                                                   @"1":@"1",
                                                                   @"2":@"1",
                                                                   @"3":@"0"
                                                                   }];
}

- (void)creatTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    
    if (section == 0) {
        return folded?_arr.count:0;
    } else if (section == 1) {
        return folded?_arr.count:0;
    } else if (section == 2) {
        return folded?_arr.count:0;
    } else {
        return folded?_arr.count:0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LGJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[LGJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    
    if (section == 0) {
        [headerView setFoldSectionHeaderViewWithTitle:@"我是第一个Section" detail:@"9999" type: HerderStyleTotal section:0 canFold:YES];
    } else if (section == 1) {
        [headerView setFoldSectionHeaderViewWithTitle:@"我是第二个Section" detail:@"8888" type:HerderStyleTotal section:1 canFold:YES];
    } else if (section == 2){
        [headerView setFoldSectionHeaderViewWithTitle:@"我是第三个Section" detail:nil type:HerderStyleNone section:2 canFold:YES];
    } else {
        [headerView setFoldSectionHeaderViewWithTitle:@"我是第四个Seciton" detail:@"777" type:HerderStyleTotal section:3 canFold:NO];
    }
    headerView.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    headerView.fold = folded;
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_arr objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
