//
//  XPQuanziFeedbackViewController.m
//  zteiwh
//
//  Created by 相约在冬季 on 2017/11/7.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziFeedbackViewController.h"
#define pictureHW (SCREEN_WIDTH - 5*10)/4
#define MaxImageCount 9

@interface XPQuanziFeedbackViewController ()

@end

@implementation XPQuanziFeedbackViewController

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
    [self setShowFooterRefresh:NO];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"举报";
    
    //创建“提交”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"提交" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==1) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 160;
            
            break;
        case 1: {
            //上传图片
            NSInteger imgNum = [self.imagePickerArray count];
            NSInteger rowNum = imgNum/4;
            NSInteger ysNum = imgNum%4;
            if(ysNum>=0) {
                rowNum += 1;
            }
            return (pictureHW+10)*rowNum +10;
            
            break;
        }
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section!=1) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    //创建“照片”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:@"照片"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"ZTEMineFeedbackViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            //创建“反馈输入框”
            self.textView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
            self.textView.limitNum = 200;
            self.textView.placeHolder = @"请输入您的举报内容";
            [cell.contentView addSubview:self.textView];
            
            break;
        }
        case 1: {
            //上传图片
            
            //清空二进制流存储器
            [self.dataArr removeAllObjects];
            
            //上传图片按钮
            NSInteger imageCount = [self.imagePickerArray count];
            for (NSInteger i = 0; i < imageCount; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%4)*(pictureHW+10), 10 +(i/4)*(pictureHW+10), pictureHW, pictureHW)];
                [imgView setContentMode:UIViewContentModeScaleAspectFill];
                [imgView setClipsToBounds:YES];
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
                [btnDelete setImage:[UIImage imageNamed:@"public_delete_photo"] forState:UIControlStateNormal];
                [btnDelete addTarget:self action:@selector(btnDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
                [imgView addSubview:btnDelete];
            }
            if (imageCount < MaxImageCount) {
                self.btnAdd = [[UIButton alloc]initWithFrame:CGRectMake(10 + (imageCount%4)*(pictureHW+10), 10 +(imageCount/4)*(pictureHW+10), pictureHW, pictureHW)];
                [self.btnAdd setUserInteractionEnabled:YES];
                [self.btnAdd setBackgroundImage:[UIImage imageNamed:@"public_add_photo"] forState:UIControlStateNormal];
                [self.btnAdd addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:self.btnAdd];
            }
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
 *  提交反馈信息
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"提交举报信息");
    
    [self.view endEditing:YES];
    
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    NSString *contentStr = self.textView.textView.text;
    
    //判断字符不能超过100字
    if(IsStringEmpty(contentStr)) {
        [MBProgressHUD showMessage:@"举报的内容不能为空" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:contentStr]) {
        [MBProgressHUD showMessage:@"举报内容不能包含表情" toView:self.view];
        return;
    }else if([contentStr length]<10) {
        [MBProgressHUD showMessage:@"举报内容不能少于10个字符" toView:self.view];
        return;
    }else if([contentStr length]>200) {
        [MBProgressHUD showMessage:@"举报内容不能多于200个字符" toView:self.view];
        return;
    }
    
//    if(self.dataArr.count<=0) {
//        [MBProgressHUD showError:@"请上传照片" toView:self.view];
//        return;
//    }
    
    [MBProgressHUD showMsg:@"数据提交中..." toView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD:self.view];
        [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"ucenter" forKey:@"app"];
//    [param setValue:@"feedback" forKey:@"act"];
//    [param setValue:contentStr forKey:@"content"];
//    [HttpRequestEx postWithImgPath:SERVICE_URL params:param imgArr:self.dataArr success:^(id json) {
//        [MBProgressHUD hideHUD:self.view];
//        NSString *msg = [json objectForKey:@"msg"];
//        NSString *code = [json objectForKey:@"code"];
//        if([code isEqualToString:SUCCESS]) {
//            [MBProgressHUD showSuccess:@"反馈成功" toView:self.view];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        }else{
//            [MBProgressHUD showMessage:msg toView:self.view];
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@",[error description]);
//        [MBProgressHUD hideHUD:self.view];
//    }];
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
