//
//  HCMineInfoViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineInfoViewController.h"
#import "MHDatePicker.h"
#import "AddressPickView.h"

@interface HCMineInfoViewController () {
    NSMutableArray *titleArr;
    
    UIButton *btnTmp;
    
    //头像
    NSData *_avatarData;
    //手持身份证图片
    NSData *_handData;
    //身份证正面图片
    NSData *_faceData;
    //身份证反面图片
    NSData *_oppositeData;
}

@property (strong, nonatomic) MHDatePicker *selectDatePicker;

@end

@implementation HCMineInfoViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的资料";
    
    //创建“确定”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc addTarget:self action:@selector(btnFuncOKClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
    //创建“数据源”
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@[@"昵称",@"请输入您的昵称",@"0"],
                          @[@"出生年月",@"请选择您的出生年月",@"1"],
                          @[@"联系方式",@"请输入您的联系方式",@"0"],
                          @[@"信用等级",@"",@"0"],
                          @[@"联系地址",@"请选择省市区",@"1"],
                          @[@"",@"请输入您的详细地址",@"0"]]];
    [titleArr addObject:@[@[@"身份证信息",@"",@"0"],
                          @[@"姓名",@"请输入您的姓名",@"0"],
                          @[@"身份证号",@"请输入您的身份证号",@"0"]]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            //第一区块
            return 1;
            
            break;
        case 1:
            //第二区块
            return 6;
            
            break;
        case 2:
            //第三区块
            return 3;
            
            break;
        case 3:
            //第四区块
            return 1;
            
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 80;
            
            break;
        case 1:
            return 45;
            
            break;
        case 2:
            return 45;
            
            break;
        case 3:
            return 120;
            break;
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==2) {
        return 0.0001;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineInfoViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        //头像
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 80, 20)];
        [lbMsg setText:@"头像"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“会员头像”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 60, 60)];
        [btnFunc setContentMode:UIViewContentModeScaleAspectFill];
        [btnFunc setClipsToBounds:YES];
        [btnFunc.layer setCornerRadius:30];
        [btnFunc sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [btnFunc setTag:100];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
        //创建“尖头”
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 35, 5.5, 10)];
        [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
        [cell.contentView addSubview:imgView2];
        
    }else if(indexPath.section==3) {
        //证件照
        NSArray *itemArr = @[@"手持身份证照片",@"身份证正面",@"身份证反面"];
        CGFloat tWidth = SCREEN_WIDTH/3;
        for (int i=0; i<3; i++) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 10, tWidth, 100)];
            [cell.contentView addSubview:backView];
            
            //创建“图片按钮”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((backView.frame.size.width-65)/2, 0, 65, 65)];
            switch (i) {
                case 0: {
                    //手持身份证照片
                    if(!IsStringEmpty(self.userModel.idcard_hand_img)) {
                        [btnFunc sd_setImageWithURL:[NSURL URLWithString:self.userModel.idcard_hand_img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    }else{
                        [btnFunc setImage:[UIImage imageNamed:@"pic_icon_add"] forState:UIControlStateNormal];
                    }
                    
                    break;
                }
                case 1: {
                    //身份证正面
                    if(!IsStringEmpty(self.userModel.idcard_face_img)) {
                        [btnFunc sd_setImageWithURL:[NSURL URLWithString:self.userModel.idcard_face_img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    }else{
                        [btnFunc setImage:[UIImage imageNamed:@"pic_icon_add"] forState:UIControlStateNormal];
                    }
                    
                    break;
                }
                case 2: {
                    //身份证反面
                    if(!IsStringEmpty(self.userModel.idcard_opposite_img)) {
                        [btnFunc sd_setImageWithURL:[NSURL URLWithString:self.userModel.idcard_opposite_img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    }else{
                        [btnFunc setImage:[UIImage imageNamed:@"pic_icon_add"] forState:UIControlStateNormal];
                    }
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            [btnFunc setTag:i+101];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btnFunc];
            
            //创建“名称”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, backView.frame.size.width, 20)];
            [lbMsg setText:itemArr[i]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentCenter];
            [lbMsg setFont:FONT14];
            [backView addSubview:lbMsg];
        }
        
    }else {
        NSArray *itemArr = [[titleArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“内容”
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-125, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setTextColor:COLOR9];
        [tbxContent setTextAlignment:NSTextAlignmentRight];
        [tbxContent setFont:FONT15];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if(indexPath.section==1) {
            [tbxContent setTag:100+indexPath.row];
        }else if(indexPath.section==2) {
            [tbxContent setTag:1000+indexPath.row];
        }
        
        [cell.contentView addSubview:tbxContent];
        
        switch (indexPath.section) {
            case 1: {
                switch (indexPath.row) {
                    case 0: {
                        //昵称
                        [tbxContent setText:self.userModel.nickname];
                        
                        break;
                    }
                    case 1: {
                        //出生年月
                        [tbxContent setText:self.userModel.birthday];
                        
                        break;
                    }
                    case 2: {
                        //联系方式
                        [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
                        [tbxContent setText:self.userModel.tel];
                        
                        break;
                    }
                    case 3: {
                        //信用等级
                        [tbxContent setEnabled:NO];
                        [tbxContent setText:self.userModel.level_name];
                        
                        break;
                    }
                    case 4: {
                        //联系地址
                        [tbxContent setText:self.userModel.area_name];
                        
                        break;
                    }
                    case 5: {
                        //详细地址
                        [tbxContent setText:self.userModel.address];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
            case 2: {
                switch (indexPath.row) {
                    case 1: {
                        //姓名
                        [tbxContent setText:self.userModel.realname];
                        
                        break;
                    }
                    case 2: {
                        //身份证号
                        [tbxContent setText:self.userModel.idcard_no];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
                
            default:
                break;
        }
        
        //创建“右侧尖头”
        if([itemArr[2] integerValue]==1) {
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView2];
            
            [tbxContent setEnabled:NO];
        }
        
        if(indexPath.section==2 && indexPath.row==0) {
            [tbxContent setEnabled:NO];
        }
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UITextField *tbxContent = [cell.contentView viewWithTag:100+indexPath.row];
            
            switch (indexPath.row) {
                case 1: {
                    //出生年月
                    [self.view endEditing:YES];
                    
                    _selectDatePicker = [[MHDatePicker alloc] init];
                    _selectDatePicker.isBeforeTime = YES;
                    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
                    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
                        NSDate * now = [NSDate date];
                        if ([selectedDate timeIntervalSince1970] > [now timeIntervalSince1970]) {
                            [MBProgressHUD showMessage:@"年月日不能大于当前时间" toView:self.view];
                        }else{
                            //MM月dd日 HH:mm
                            NSString *birthday = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                            tbxContent.text = birthday;
                            
                            self.userModel.birthday = birthday;
                        }
                    }];
                    
                    break;
                }
                case 4: {
                    //联系地址
                    [self.view endEditing:YES];
                    AddressPickView *addressPickView = [AddressPickView CreateInstance];
                    [self.view addSubview:addressPickView];
                    addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
                        NSLog(@"%@ %@",cityIds,nameStr);
                        //省市区名称
                        [tbxContent setText:nameStr];
                        
                        //值存储
                        NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
                        self.userModel.province_id = itemArr[0];
                        self.userModel.city_id = itemArr[1];
                        self.userModel.area_id = itemArr[2];
                        self.userModel.area_name = nameStr;
                    };
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //昵称
            self.userModel.nickname = textField.text;
            
            break;
        }
        case 102: {
            //联系方式
            self.userModel.tel = textField.text;
            
            break;
        }
        case 105: {
            //联系详细地址
            self.userModel.address = textField.text;
            
            break;
        }
        case 1001: {
            //姓名
            self.userModel.realname = textField.text;
            
            break;
        }
        case 1002: {
            //身份证号
            if (textField.text.length > 19) {
                textField.text = [textField.text substringToIndex:19];
            }
            self.userModel.idcard_no = textField.text;
            
            break;
        }
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

//上传图片
- (void)btnFuncClick:(UIButton *)btnSender {
    btnTmp = btnSender;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"无法打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机相册选择");
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//UIImagePickerControlDelegate委托事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取相机返回的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取Image
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    [btnTmp setImage:photoImg forState:UIControlStateNormal];
    
    NSData *imgData = UIImageJPEGRepresentation(photoImg, 0.7);
    
    switch (btnTmp.tag) {
        case 100: {
            //头像
            _avatarData = imgData;
            
            break;
        }
        case 101: {
            //手持身份证照片
            _handData = imgData;
            
            break;
        }
        case 102: {
            //身份证正面
            _faceData = imgData;
            
            break;
        }
        case 103: {
            //身份证反面
            _oppositeData = imgData;
            
            break;
        }
            
        default:
            break;
    }
    
}

//提交信息
- (void)btnFuncOKClick:(UIButton *)btnSender {
    NSLog(@"提交信息");
    [self.view endEditing:YES];
    
    //昵称验证
    NSString *nickName = self.userModel.nickname;
    if(IsStringEmpty(nickName)) {
        [MBProgressHUD showError:@"请输入您的昵称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nickName]) {
        [MBProgressHUD showError:@"昵称不能包含表情" toView:self.view];
        return;
    }if([nickName length]>10) {
        [MBProgressHUD showError:@"昵称不能超过10个字符" toView:self.view];
        return;
    }
    
    //生日验证
    if(IsStringEmpty(self.userModel.birthday)) {
        [MBProgressHUD showError:@"请选择出生年月" toView:self.view];
        return;
    }
    
    //联系方式验证
    if (![self.userModel.tel isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    
    //省市区验证
    if(IsStringEmpty(self.userModel.province_id) ||
        IsStringEmpty(self.userModel.city_id) ||
        IsStringEmpty(self.userModel.area_id)) {
        [MBProgressHUD showError:@"请选择省市区" toView:self.view];
        return;
    }
    
    //详细地址验证
    if(IsStringEmpty(self.userModel.address)) {
        [MBProgressHUD showError:@"请输入您的详细地址" toView:self.view];
        return;
    }
    
    //真实姓名验证
    NSString *realname = self.userModel.realname;
    if(IsStringEmpty(realname)) {
        [MBProgressHUD showError:@"请输入您的姓名" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:realname]) {
        [MBProgressHUD showError:@"姓名不能包含表情" toView:self.view];
        return;
    }if([realname length]>10) {
        [MBProgressHUD showError:@"姓名不能超过10个字符" toView:self.view];
        return;
    }
    
    //身份证验证
    if(![self.userModel.idcard_no IsIdentityCard]) {
        [MBProgressHUD showError:@"请输入正确的身份证号" toView:self.view];
        return;
    }
    
    NSMutableArray *imageArr = [NSMutableArray array];
    //头像
    if(IsStringEmpty(self.userModel.avatar) && !_avatarData) {
        [MBProgressHUD showError:@"请上传头像" toView:self.view];
        return;
    }
    if(_avatarData) {
        [imageArr addObject:@[@"avatar",_avatarData]];
    }
    
    //手持身份证图片
    if(IsStringEmpty(self.userModel.idcard_hand_img) && !_handData) {
        [MBProgressHUD showError:@"请上传手持身份证图片" toView:self.view];
        return;
    }
    if(_handData) {
        [imageArr addObject:@[@"idcard_hand_img",_handData]];
    }
    
    //身份证正面图片
    if(IsStringEmpty(self.userModel.idcard_face_img) && !_faceData) {
        [MBProgressHUD showError:@"请上传身份证正面图片" toView:self.view];
        return;
    }
    if(_faceData) {
        [imageArr addObject:@[@"idcard_face_img",_faceData]];
    }
    
    //身份证反面图片
    if(IsStringEmpty(self.userModel.idcard_opposite_img) && !_oppositeData) {
        [MBProgressHUD showError:@"请上传身份证反面图片" toView:self.view];
        return;
    }
    if(_oppositeData) {
        [imageArr addObject:@[@"idcard_opposite_img",_oppositeData]];
    }
    
    [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"editBase" forKey:@"act"];
    [param setValue:nickName forKey:@"nickname"];
    [param setValue:self.userModel.birthday forKey:@"birthday"];
    [param setValue:self.userModel.tel forKey:@"tel"];
    [param setValue:self.userModel.province_id forKey:@"province_id"];
    [param setValue:self.userModel.city_id forKey:@"city_id"];
    [param setValue:self.userModel.area_id forKey:@"area_id"];
    [param setValue:self.userModel.area_name forKey:@"area_name"];
    [param setValue:self.userModel.address forKey:@"address"];
    [param setValue:realname forKey:@"realname"];
    [param setValue:self.userModel.idcard_no forKey:@"idcard_no"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    
    [HttpRequestEx postWithImageURL:SERVICE_URL params:param imgArr:imageArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            NSDictionary *dataDic = [json objectForKey:@"data"];
            
            //预先清除
            [[HelperManager CreateInstance] clearAcc];
            
            //设置本地缓存
            [self setUserDefaultInfo:dataDic];
            
            HCUserModel *userInfo = [HCUserModel mj_objectWithKeyValues:dataDic];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack(userInfo);
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
    
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
