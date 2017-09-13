//
//  SearchViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/23.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong) UISearchBar * search_Bar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation SearchViewController

- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索";
    
    [self search_Bar];
    
   
}

//创建表示图
-(void)createTableView{
    
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 130, KSCREENWIDTH, KSCREENHEIGHT-130) style:UITableViewStyleGrouped];
    }
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.scrollEnabled = NO;
    
    
    [self.view addSubview:_tableView];
    
}

//显示多少数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _titles.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * KSCREENWIDTH / 375.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _titles[indexPath.row];
    
        cell.textLabel.textColor = [UIColor grayColor];
 
        cell.imageView.image = [UIImage imageNamed:@"sousuo"];
    
        return cell;
        
    } else {
        cell.textLabel.text = @"清除历史记录";
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.textLabel.textColor = [UIColor grayColor];
        
        return cell;
    }
}

//点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        _search_Bar.text = self.titles[indexPath.row];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        
    } else {
        
        self.titles = nil;
        
        [self.tableView removeFromSuperview];
        
        //保存数据
        NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filename = [Path stringByAppendingPathComponent:@"test"];
        [NSKeyedArchiver archiveRootObject:self.titles toFile:filename];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}


- (UISearchBar *)search_Bar{
    if (_search_Bar == nil){
        _search_Bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 80, KSCREENWIDTH, 50)];
        _search_Bar.showsCancelButton = YES;
        _search_Bar.delegate = self;
        for (id obj in [_search_Bar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];

                    }
                    if ([obj2 isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
                    {
                        [obj2 removeFromSuperview];
                      
                    }
                    if ([obj2 isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                        UITextField *text = (UITextField *)obj2;
                        text.layer.borderColor = [UIColor lightGrayColor].CGColor;
                        text.layer.borderWidth = 1;
                        text.layer.masksToBounds = YES;
                        text.layer.cornerRadius = 10;
                    }
                    if([obj2 conformsToProtocol:@protocol(UITextInputTraits)]) {
                        //改变搜索按钮名称
                        [(UITextField *)obj2 setReturnKeyType: UIReturnKeyDone];
                    } else {
                        for(UIView *subSubView in [obj2 subviews]) {
                            if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
                                [(UITextField *)subSubView setReturnKeyType: UIReturnKeyDone];
                            }
                        }      
                    }
                
                }
            }
        }
        
        [self.view addSubview:_search_Bar];
    }
    return _search_Bar;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
    
   
    NSString *obj = searchBar.text;
  
    [self.titles addObject:obj];
    
    //保存数据
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:@"test"];
    [NSKeyedArchiver archiveRootObject:self.titles toFile:filename];

    
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: YES];
    
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:@"test"];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
    self.titles = arr;
    
   
    if (self.titles.count > 0) {
        [self createTableView];
    }
}


- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(_search_Bar.text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
