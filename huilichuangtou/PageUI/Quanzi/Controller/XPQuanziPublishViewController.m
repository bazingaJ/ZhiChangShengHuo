//
//  XPQuanziPublishViewController.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziPublishViewController.h"
#import "XPQuanziLocationViewController.h"
#import "XPQuanziTagsViewController.h"
#import "HCWKWebExViewController.h"

#define pictureHW (SCREEN_WIDTH - 5*10)/4
#define MaxImageCount 9

@interface XPQuanziPublishViewController () {
    //选择标签
    NSString *tagIds;
}

@end

@implementation XPQuanziPublishViewController

/**
 *  imagePicker队列
 */
-(NSMutableArray *)imagePickerArray {
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

- (NSMutableArray *)assetsArr {
    if(!_assetsArr) {
        _assetsArr = [NSMutableArray array];
    }
    return _assetsArr;
}

- (NSMutableArray *)photosArr {
    if(!_photosArr) {
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布详情";
    
    //创建“发布按钮”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==2) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //描述输入框
            return 175;
            
            break;
        case 1: {
            //上传图片框
            NSInteger imgNum = [self.imagePickerArray count];
            NSInteger rowNum = imgNum/4;
            NSInteger ysNum = imgNum%4;
            if(ysNum>=0) {
                rowNum += 1;
            }
            return (pictureHW+10)*rowNum +10;
            
            break;
        }
        case 2:
            return 45;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"YBCampusPublishViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            //创建“描述输入框”
            self.tbxContent = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
            self.tbxContent.limitNum = 300;
            self.tbxContent.placeHolder = @"描述(请输入300字以内的文字)";
            [self.tbxContent.textView setFont:FONT15];
            [self.tbxContent.textView setReturnKeyType:UIReturnKeyDone];
            [self.tbxContent.layer setBorderColor:[UIColor clearColor].CGColor];
            [cell.contentView addSubview:self.tbxContent];
            
            break;
        }
        case 1: {
            
            //清空二进制流存储器
            [self.dataArr removeAllObjects];
            
            //上传图片按钮
            NSInteger imageCount = [self.imagePickerArray count];
            for (NSInteger i = 0; i < imageCount; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%4)*(pictureHW+10), 10 +(i/4)*(pictureHW+10), pictureHW, pictureHW)];
                imgView.tag = 2000 + i;
                imgView.userInteractionEnabled = YES;
                imgView.image = self.imagePickerArray[i];
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
                [imgView addGestureRecognizer:tapGes];
                [cell.contentView addSubview:imgView];
                
                //UIImage转NSData
                NSData *imgData = UIImageJPEGRepresentation(imgView.image, 0.7);
                //NSData *imgData = UIImagePNGRepresentation(imgView.image);
                [self.dataArr addObject:imgData];
                
                //添加“删除”按钮
                UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
                btnDelete.frame = CGRectMake(pictureHW - 15 + 5, -5, 15, 15);
                [btnDelete setImage:[UIImage imageNamed:@"campus_delete_photo"] forState:UIControlStateNormal];
                [btnDelete addTarget:self action:@selector(btnDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
                [imgView addSubview:btnDelete];
            }
            if (imageCount < MaxImageCount) {
                self.btnAdd = [[UIButton alloc]initWithFrame:CGRectMake(10 + (imageCount%4)*(pictureHW+10), 10 +(imageCount/4)*(pictureHW+10), pictureHW, pictureHW)];
                [self.btnAdd setUserInteractionEnabled:YES];
                [self.btnAdd setBackgroundImage:[UIImage imageNamed:@"quanzi_add_photo"] forState:UIControlStateNormal];
                [self.btnAdd addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:self.btnAdd];
            }
            
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    //创建“图标”
                    self.imgLocation = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 15, 20)];
                    [self.imgLocation setImage:[UIImage imageNamed:@"quanzi_location_selected_no"]];
                    [cell.contentView addSubview:self.imgLocation];
                    
                    //创建“所在位置”
                    self.lbLocation = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, SCREEN_WIDTH-65, 25)];
                    [self.lbLocation setText:@"所在位置"];
                    [self.lbLocation setTextColor:COLOR3];
                    [self.lbLocation setTextAlignment:NSTextAlignmentLeft];
                    [self.lbLocation setFont:FONT16];
                    [cell.contentView addSubview:self.lbLocation];
                    
                    //创建“尖头”
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 16, 7, 13)];
                    imgView.image = [UIImage imageNamed:@"arrow_right"];
                    [cell.contentView addSubview:imgView];
                    
                    //创建“分割线”
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
                    [lineView setBackgroundColor:LINE_COLOR];
                    [cell.contentView addSubview:lineView];
                    
                    break;
                }
                case 1: {
                    //创建“图标”
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14.5, 15.5, 15.5)];
                    [imgView setImage:[UIImage imageNamed:@"quanzi_location_tags"]];
                    [cell.contentView addSubview:imgView];
                    
                    //创建“标签”
                    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 65, 25)];
                    [lbMsg setText:@"标签"];
                    [lbMsg setTextColor:COLOR3];
                    [lbMsg setTextAlignment:NSTextAlignmentLeft];
                    [lbMsg setFont:FONT16];
                    [cell.contentView addSubview:lbMsg];
                    
                    //创建“标签”
                    self.lblTag = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-140, 25)];
                    [self.lblTag setTextColor:COLOR3];
                    [self.lblTag setTextAlignment:NSTextAlignmentRight];
                    [self.lblTag setFont:FONT16];
                    [cell.contentView addSubview:self.lblTag];
                    
                    //创建“尖头”
                    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 16, 7, 13)];
                    imgView2.image = [UIImage imageNamed:@"arrow_right"];
                    [cell.contentView addSubview:imgView2];
                    
                    //创建“分割线”
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
                    [lineView setBackgroundColor:LINE_COLOR];
                    [cell.contentView addSubview:lineView];
                    
                    break;
                }
                case 2: {
                    //发布协议
                    NSString *titleStr = @"点击【发布】,代表您已阅读并同意《圈子使用协议》";
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 45)];
                    [btnFunc setTitle:titleStr forState:UIControlStateNormal];
                    [btnFunc setTitleColor:COLOR6 forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT14];
                    [btnFunc setImage:[UIImage imageNamed:@"quanzi_location_selected"] forState:UIControlStateNormal];
                    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
                    [btnFunc addTouch:^{
                        NSLog(@"使用协议");
                        
                        HCWKWebExViewController *aboutView = [[HCWKWebExViewController alloc] init];
                        aboutView.title = @"致昌生活平台用户内容产生使用协议";
                        //aboutView.contentStr = contentStr;
                        [self.navigationController pushViewController:aboutView animated:YES];
                        
                    }];
                    [cell.contentView addSubview:btnFunc];
                    
                    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
                    //字体颜色
                    [attrStr addAttribute:NSForegroundColorAttributeName
                                    value:MAIN_COLOR
                                    range:NSMakeRange(titleStr.length-8, 8)];
                    //            //字体大小
                    //            [attrStr addAttribute:NSFontAttributeName
                    //                            value:FONT13
                    //                            range:NSMakeRange(0, 1)];
                    btnFunc.titleLabel.attributedText = attrStr;
                    
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    switch (indexPath.section) {
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    //选择地址
                    XPQuanziLocationViewController *locationView = [[XPQuanziLocationViewController alloc] init];
                    if (self.poi) {
                        locationView.oldPoi = self.poi;
                    }
                    WS(weakSelf);
                    [locationView setSuccessBlock:^(AMapPOI *obj){
                        weakSelf.poi = obj;
                        if (obj) {
                            //设置地址
                            if (obj.address.length > 0) {
                                NSString *address = [NSString stringWithFormat:@"%@·%@",self.poi.city,self.poi.address];
                                [weakSelf.lbLocation setText:address];
                            }else{
                                [weakSelf.lbLocation setText:[NSString stringWithFormat:@"%@",self.poi.city]];
                            }
                            [self.imgLocation setImage:[UIImage imageNamed:@"quanzi_location_selected_yes"]];
                        }else{
                            [weakSelf.lbLocation setText:@"所在位置"];
                            [self.imgLocation setImage:[UIImage imageNamed:@"quanzi_location_selected_no"]];
                        }
                    }];
                    [self.navigationController pushViewController:locationView animated:YES];
                    
                    break;
                }
                case 1: {
                    //标签
                    XPQuanziTagsViewController *tagsView = [[XPQuanziTagsViewController alloc] init];
                    tagsView.callBack = ^(NSString *tag_id, NSString *tag_name) {
                        tagIds = tag_id;
                        [self.lblTag setText:tag_name];
                    };
                    [self.navigationController pushViewController:tagsView animated:YES];
                    
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

-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.photos = self.photosArr;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndex = tap.view.tag-2000;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

/**
 *  添加按钮功能
 */
- (void)btnAddClick:(UIButton *)btnSender {
    NSLog(@"添加图片");
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"无法打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机相册选择");
        ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
        // MaxCount, Default = 9
        pickerVc.maxCount = MaxImageCount;
        // Jump AssetsVc
        pickerVc.status = PickerViewShowStatusCameraRoll;
        // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
        pickerVc.photoStatus = PickerPhotoStatusPhotos;
        // Recoder Select Assets
        pickerVc.selectPickers = self.assetsArr;
        // Desc Show Photos, And Suppor Camera
        pickerVc.topShowPhotoPicker = YES;
        pickerVc.isShowCamera = NO;
        // CallBack
        pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
            self.assetsArr = status.mutableCopy;
            [self.imagePickerArray removeAllObjects];
            [self.photosArr removeAllObjects];
            for(int i=0;i<self.assetsArr.count;i++) {
                // 如果是本地ZLPhotoAssets就从本地取，否则从网络取
                NSURL *photoURL;
                if ([[self.assetsArr objectAtIndex:i] isKindOfClass:[ZLPhotoAssets class]]) {
                    photoURL = (NSURL *)[self.assetsArr[i] assetURL];
                    [self.imagePickerArray addObject:[self.assetsArr[i] originImage]];
                }else if ([[self.assetsArr objectAtIndex:i] isKindOfClass:[ZLCamera class]]){
                    photoURL = (NSURL *)[NSURL URLWithString:[self.assetsArr[i] imagePath]];
                    [self.imagePickerArray addObject:[self.assetsArr[i] originImage]];
                }else if ([[self.assetsArr objectAtIndex:i] isKindOfClass:[NSString class]]){
                    photoURL = (NSURL *)[self.assetsArr[i] assetURL];
                    UIImage *tmpImage = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:photoURL]];
                    [self.imagePickerArray addObject:tmpImage];
                }
                
                //设置图片浏览数据源
                if(photoURL) {
                    ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                    photo.photoURL = photoURL;
                    [self.photosArr addObject:photo];
                }
            }
            NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [pickerVc showPickerVc:self];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取相机返回的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取Image
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    ZLPhotoAssets *asset = [ZLPhotoAssets assetWithImage:image];
    [self.assetsArr addObject:asset];
    [self.imagePickerArray addObject:image];
    
    //刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


/**
 *  删除按钮功能
 */
- (void)btnDeleteClick:(UIButton *)btnSender {
    NSLog(@"删除图片");
    
    [self.view endEditing:YES];
    
    if ([(UIButton *)btnSender.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(UIButton *)btnSender.superview;
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - 2000)];
        [self.assetsArr removeObjectAtIndex:imageView.tag - 2000];
        [imageView removeFromSuperview];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

/**
 *  确定按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    [self.view endEditing:YES];

    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;

    NSString *commStr = self.tbxContent.textView.text;
    NSString *addressStr = [self.lbLocation.text isEqualToString:@"所在位置"]?@"" : self.lbLocation.text;

    //图片和内容至少要满足一个条件
    if(IsStringEmpty(commStr) && !self.dataArr.count) {
        [MBProgressHUD showError:@"请输入内容或上传图片" toView:self.view];
        return;
    }
    if(!IsStringEmpty(commStr) && [commStr length]>300) {
        [MBProgressHUD showError:@"发布的内容不能超过300个字符" toView:self.view];
        return;
    }
    
    //标签验证
    if(IsStringEmpty(tagIds)) {
        [MBProgressHUD showError:@"请选择标签" toView:self.view];
        return;
    }
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"友情提醒" message:@"点击【同意】,即代表您已阅读并同意《圈子使用协议》，平台即将对您发布的内容进行审核，如有不良内容，平台有权删除您发布的内容" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"同意");
        
        [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"dynamic" forKey:@"app"];
        [param setValue:@"publish" forKey:@"act"];
        [param setValue:commStr forKey:@"content"];
        [param setValue:addressStr forKey:@"address"];
        [param setValue:tagIds forKey:@"cate_ids"];
        [param setValue:[NSString stringWithFormat:@"%f",APP_DELEGATE.longitude] forKey:@"lng"];
        [param setValue:[NSString stringWithFormat:@"%f",APP_DELEGATE.latitude] forKey:@"lat"];
        [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
        [param setValue:APP_DELEGATE.adcode forKey:@"adcode"];
        [HttpRequestEx postWithImgPath:SERVICE_URL params:param imgArr:self.dataArr success:^(id json) {
            [MBProgressHUD hideHUD:self.view];
            NSString *msg = [json objectForKey:@"msg"];
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS]) {
                [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
                
                //停顿1秒后返回
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSDictionary *dataDic = [json objectForKey:@"data"];
                    if(dataDic && [dataDic count]>0) {
                        if(self.callBack) {
                            self.callBack(dataDic);
                        }
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
        
    }];
    [aler addAction:cancelAction];
    [aler addAction:okAction];
    [self presentViewController:aler animated:YES completion:nil];

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
