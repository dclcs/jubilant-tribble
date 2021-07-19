//
//  GTNewsViewController.m
//  NewsApp
//
//  Created by dcl on 2021/4/18.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
@interface GTNewsViewController () <UITableViewDataSource,UITableViewDelegate, GTNormalTableViewCellDelegate>
@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) NSArray *dataArray;
@property(nonatomic, strong, readwrite) GTListLoader *listLoader;
@end

@implementation GTNewsViewController

/// 新闻页面初始化函数
-(instancetype) init{
    self = [super init];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        self.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
        
//        _dataArray = @[].mutableCopy;
//        for (int i = 0 ; i < 20; i ++) {
//            [_dataArray addObject:@(i)];
//        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    self.listLoader = [[GTListLoader alloc] init];
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
        NSLog(@"");
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    GTDetailViewController *controller = [[GTDetailViewController alloc] initWithUrlString:item.articaleUrl];;
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell){
         cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

/// TableView中的每一个Cell处理
/// @param tableViewCell 这个cell的位置
/// @param deleteButton 删除按钮
-(void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton{
//    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    //循环引用问题
//    __weak typeof(self) wself = self;
//    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
//        __strong typeof(self)strongSelf = wself;
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
//        }];
//
}

@end
