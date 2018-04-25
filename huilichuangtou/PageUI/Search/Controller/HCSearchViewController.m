//
//  HCSearchViewController.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "HCSearchViewController.h"
#import "KSearchView.h"
#import "KSearchSuggestionViewController.h"
#import "KSearchResultListViewController.h"
#import "HCSearchPopupView.h"

#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]

@interface HCSearchViewController () {
    NSInteger typeVal;
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) KSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) KSearchSuggestionViewController *searchSuggestVC;

@end

@implementation HCSearchViewController

- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray arrayWithObjects:@"悦诗风吟", @"洗面奶", @"兰芝", @"面膜", @"篮球鞋", @"阿迪达斯", @"耐克", @"运动鞋", nil];
    }
    return _hotArray;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_historyArray) {
            self.historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}


- (KSearchView *)searchView
{
//    WS(weakSelf);
//    if (!_searchView) {
//        _searchView = [[KSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) hotArr:self.hotArray historyArr:self.historyArray];
//        _searchView.tapAction = ^(NSString *str) {
//            [weakSelf pushToSearchResultWithSearchStr:str];
//        };
//        [self.view addSubview:_searchView];
//    }
    WS(weakSelf);
    [_searchView removeFromSuperview];
    _searchView = [[KSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) hotArr:self.hotArray historyArr:self.historyArray];
    _searchView.tapAction = ^(NSString *str) {
        [weakSelf pushToSearchResultWithSearchStr:str];
    };
    [self.view addSubview:_searchView];
    return _searchView;
}


- (KSearchSuggestionViewController *)searchSuggestVC
{
    if (!_searchSuggestVC) {
        self.searchSuggestVC = [[KSearchSuggestionViewController alloc] init];
        _searchSuggestVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT);
        _searchSuggestVC.view.hidden = YES;
        _searchSuggestVC.searchBlock = ^(NSString *searchTest) {
            //[weakSelf pushToSearchResultWithSearchStr:searchTest];
        };
    }
    return _searchSuggestVC;
}

- (void)viewDidLoad {
    [self setLeftButtonItemHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认是股权众筹
    typeVal = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setBarButtonItem];
//    [self searchView];
    [self.view addSubview:self.searchSuggestVC.view];
    [self addChildViewController:_searchSuggestVC];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self searchView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 回收键盘
    [self.searchBar resignFirstResponder];
    _searchSuggestVC.view.hidden = YES;
}

- (void)setBarButtonItem
{
    [self.navigationItem setHidesBackButton:YES];
    
    //创建“背景层”
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 28)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    [titleView.layer setCornerRadius:3.0];
    self.navigationItem.titleView = titleView;
    
    //创建“类型”按钮
    HCSearchPopupView *popupView = [[HCSearchPopupView alloc] initWithFrame:CGRectMake(0, 0, 90, 28)];
    popupView.callBack = ^(NSInteger type, NSString *title) {
        NSLog(@"您点击了:%zd-%@",type,title);
        
        //设置类型值
        typeVal = type+1;
    };
    [titleView addSubview:popupView];
    
    //创建“搜索框”
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(90, 0, CGRectGetWidth(titleView.frame)-90, 28)];
    searchBar.placeholder = @"请输入您要搜索的项目";
    //searchBar.tintColor = MAIN_COLOR;
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 5.0;
    //设置搜索框的背景颜色
    //searchBar.barTintColor = [UIColor redColor];
    //searchBar.alpha = 0.2;
    //添加背景图,可以去掉外边框的灰色部分
    [searchBar setBackgroundImage:[UIImage new]];
    //[searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"clearImage"] forState:UIControlStateNormal];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    [searchBar setImage:[UIImage imageNamed:@"nav_search_white"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [titleView addSubview:searchBar];
    
    //设置输入框背景色
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    [searchTextField setTextColor:[UIColor whiteColor]];
    [searchTextField setFont:FONT15];
    [searchTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchTextField setValue:FONT14 forKeyPath:@"_placeholderLabel.font"];
    [searchTextField.layer setCornerRadius:20];
    [searchTextField.layer setMasksToBounds:YES];
    searchTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    //创建“取消”按钮
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.searchBar = searchBar;
    //[self.searchBar becomeFirstResponder];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

- (void)presentVCFirstBackClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)pushToSearchResultWithSearchStr:(NSString *)str
{
    self.searchBar.text = str;
    KSearchResultListViewController *searchResultVC = [[KSearchResultListViewController alloc] init];
    searchResultVC.type = typeVal;
    searchResultVC.searchStr = str;
    [self.navigationController pushViewController:searchResultVC animated:YES];
    [self setHistoryArrWithStr:str];
}

- (void)setHistoryArrWithStr:(NSString *)str
{
    for (int i = 0; i < _historyArray.count; i++) {
        if ([_historyArray[i] isEqualToString:str]) {
            [_historyArray removeObjectAtIndex:i];
            break;
        }
    }
    [_historyArray insertObject:str atIndex:0];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
}


#pragma mark - UISearchBarDelegate -


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self pushToSearchResultWithSearchStr:searchBar.text];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        _searchSuggestVC.view.hidden = YES;
        [self.view bringSubviewToFront:_searchView];
    } else {
        //_searchSuggestVC.view.hidden = NO;
        _searchSuggestVC.view.hidden = YES;
        [self.view bringSubviewToFront:_searchSuggestVC.view];
        [_searchSuggestVC searchTestChangeWithTest:searchBar.text];
    }
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
