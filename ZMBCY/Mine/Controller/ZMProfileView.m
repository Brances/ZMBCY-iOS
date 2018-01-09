//
//  ZMProfileView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMProfileView.h"
#import "ZMProfileViewCell.h"
#import "UIImage+Common.h"

@interface ZMProfileView()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSArray           *dataArray;
@property (nonatomic, strong) UIImageView       *thumbImageView;
@property (nonatomic, strong) UIImage           *saveImage;
@property (nonatomic, strong) MBProgressHUD     *hud;
/** 提示框 */
@property (nonatomic, strong) UIActionSheet     *actionSheet;
/** 选择性别提示 */
@property (nonatomic, strong) UIActionSheet     *sexActionSheet;
@property (nonatomic, strong) UITextField       *emailField;
@property (nonatomic, strong) UITextView        *signTextView;
@property (nonatomic, strong) UILabel           *placeText;

@end

@implementation ZMProfileView

- (UITextView *)signTextView{
    if (!_signTextView) {
        _signTextView = [UITextView new];
        _signTextView.font = [UIFont systemFontOfSize:15];
        _signTextView.returnKeyType = UIReturnKeyDone;
        _signTextView.textColor = [ZMColor appSupportColor];
        _signTextView.delegate = self;
        _signTextView.size = CGSizeMake(kScreenWidth-24, 140);
        _signTextView.x = KMarginLeft;
        _signTextView.y = 10;
        [self placeText];
    }
    return _signTextView;
}

- (UILabel *)placeText{
    if (!_placeText) {
        _placeText = [UILabel new];
        _placeText.font = [UIFont systemFontOfSize:15];
        _placeText.text = @"输入你的二次元属性吧";
        _placeText.textColor = [ZMColor appSupportColor];
        _placeText.contentMode = UIViewContentModeTop;
        [self.signTextView addSubview:_placeText];
        [_placeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(5);
        }];
    }
    return _placeText;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (!textView.text.length) {
        self.placeText.alpha = 1;
    } else {
        self.placeText.alpha = 0;
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.dataArray = @[@"昵称",@"性别",@"邮箱"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [ZMColor appGraySpaceColor];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.dataSource = self;
    _tableView.delegate =   self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
    }];
    //头部视图
    UIView *headView = [UIView new];
    headView.backgroundColor = [ZMColor appGraySpaceColor];
    headView.size = CGSizeMake(kScreenWidth, 150);
    self.thumbImageView = [UIImageView new];
    self.thumbImageView.userInteractionEnabled = YES;
    self.thumbImageView.layer.masksToBounds = YES;
    self.thumbImageView.layer.cornerRadius = 80 * 0.5;
    self.thumbImageView.image = placeholderAvatarImage;
    
    //获取缩略图
    AVFile *file = [AVFile fileWithURL:[ZMUserInfo shareUserInfo].thumb];
    WEAKSELF;
    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        weakSelf.thumbImageView.image = image;
    }];
    
    [headView addSubview:self.thumbImageView];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.centerY.mas_equalTo(headView);
    }];
    UITapGestureRecognizer *ger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callActionSheet)];
    [self.thumbImageView addGestureRecognizer:ger];
    _tableView.tableHeaderView = headView;
    
    UIImageView *photo = [UIImageView new];
    UIImage *photoImage = [UIImage imageNamed:@"avatar_camera"];
    photo.image = photoImage;
    [headView addSubview:photo];
    [photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(photoImage.size);
        make.right.mas_equalTo(self.thumbImageView.mas_right);
        make.bottom.mas_equalTo(self.thumbImageView.mas_bottom);
    }];
    
    //注册键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

//键盘弹出后将视图向上移动
-(void)keyboardWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //将文本框的相对frame转一下
    CGRect frame=[self.signTextView convertRect: self.signTextView.bounds toView:self];
    int y = frame.origin.y + frame.size.height - (self.height - keyboardSize.height);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(y > 0){
        self.frame = CGRectMake(0, -y + 64 - 5, self.frame.size.width, self.height);
    }
    [UIView commitAnimations];
}
//键盘隐藏后将视图恢复到原始状态
-(void)keyboardWillHide:(NSNotification *)note{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}
#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArray.count;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 150;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *head = [UIView new];
        head.backgroundColor = [ZMColor appGraySpaceColor];
        return head;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZMProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMProfileViewCell"];
        if (!cell) {
            cell = [[ZMProfileViewCell alloc] initWithStyle:0 reuseIdentifier:@"ZMProfileViewCell"];
        }
        cell.nameLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        cell.arrowImageView.hidden = NO;
        if (indexPath.row == 0) {
            cell.rightTextLabel.text = [ZMUserInfo shareUserInfo].userName;
        }else if(indexPath.row == 1){
            cell.rightTextLabel.text = [ZMUserInfo shareUserInfo].sexName;
        }else if(indexPath.row == 2){
            NSString *string = [ZMUserInfo shareUserInfo].emailVerfied ? @"(已验证)":@"(未验证)";
            cell.rightTextLabel.text = [NSString stringWithFormat:@"%@%@",[ZMUserInfo shareUserInfo].email,string];
        }
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        ZMProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signTitle"];
        if (!cell) {
            cell = [[ZMProfileViewCell alloc] initWithStyle:0 reuseIdentifier:@"signTitle"];
        }
        cell.arrowImageView.hidden = YES;
        cell.nameLabel.text = @"个性签名";
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signContent"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"signContent"];
    }
    if ([ZMUserInfo shareUserInfo].signature.length) {
        self.placeText.alpha = 0;
        self.signTextView.text = [ZMUserInfo shareUserInfo].signature;
    }else{
        self.placeText.alpha = 1;
    }
    
    [cell.contentView addSubview:self.signTextView];

    return cell;
}

//  点击单元格的时候取消选中单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            //选择性别
            [self callSexActionSheet];
        }else if (indexPath.row == 2){
            //点击验证邮箱
            [self alertEmailVerified];
        }
        
    }
    if (indexPath.section == 1) {

        
        
    }
}

#pragma mark - 选择照片
/**
 @ 调用ActionSheet
 */
- (void)callActionSheet{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self];
}

#pragma mark - imagePickerController照片选择代理事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    //裁剪后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.saveImage = [UIImage fixOrientation:image];
    self.thumbImageView.image = self.saveImage;
    
    //上传图片
    [self uploadThumbImage];
}

#pragma mark - 选择性别
- (void)callSexActionSheet{
    self.sexActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女",@"谜之生物", nil];
    [self.sexActionSheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self.viewController presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }else{
        if (buttonIndex == 0 || buttonIndex == 1 || buttonIndex == 2) {
            [self setupSexWithsex:buttonIndex];
        }
        
    }
}

//选择性别
- (void)setupSexWithsex:(NSInteger)sex{
    if (sex == 0) {
        sex = 2;
    }else if (sex == 1){
        sex = 1;
    }else{
        sex = 0;
    }
    
    //更新用户资料
    [[AVUser currentUser] setObject:@(sex) forKey:@"sex"];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [MBProgressHUD showPromptMessage:@"更新资料成功"];
            [[ZMUserInfo shareUserInfo] loadUserInfo: [AVUser currentUser]];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdateUserInfoNotice object:nil];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - 上传头像文件
- (void)uploadThumbImage{
    NSData *data = [self compressImageQuality:self.saveImage toByte:1000*1000];
    AVFile *file = [AVFile fileWithName:@"thumb.png" data:data];
    
    //圆形进度条
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"上传成功");
            [[AVUser currentUser] setObject:file.url forKey:@"thumb"];
            [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [MBProgressHUD showPromptMessage:@"上传成功"];
                    [[ZMUserInfo shareUserInfo] loadUserInfo: [AVUser currentUser]];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:KUpdateUserInfoNotice object:nil];
                }
            }];
        }
        NSLog(@"%@", file.url);//返回一个唯一的 Url 地址
    } progressBlock:^(NSInteger percentDone) {
        // 上传进度数据，percentDone 介于 0 和 100。
        _hud.progress = percentDone * 0.01;
        if (_hud.progress >= 1.0) {
            [_hud hide:YES];
        }
    }];
}

- (NSData *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

#pragma mark - 绑定邮箱
- (void)alertEmailVerified{
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:@"输入邮箱" preferredStyle:UIAlertControllerStyleAlert];
    [actionSheetController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入邮箱";
        _emailField = textField;
    }];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定=%@",_emailField.text);
        
        //首先验证用户的邮箱合法性，更新用户资料
        if ([ZMHelpUtil checkMailInput:_emailField.text]) {
            AVUser *user = [AVUser currentUser];
            user.email = _emailField.text;
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [MBProgressHUD showPromptMessage:@"请求邮件发送成功，请查收"];
                    //弹出验证框提示是否已经验证
                    [self isVerifiedEmail];
                }else{
                    [MBProgressHUD showPromptMessage:@"更新用户资料失败，请重试"];
                }
            }];
        }else{
            [MBProgressHUD showPromptMessage:@"请输入正确的邮箱"];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:determineAction];
    [actionSheetController addAction:cancelAction];
    
    [self.viewController presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark - 弹出是否验证的弹窗
- (void)isVerifiedEmail{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"邮箱验证" message:@"邮件已发送，请前往邮箱验证" preferredStyle:UIAlertControllerStyleAlert];
    //添加确定和取消按钮
    UIAlertAction *cacleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self refreshUserInfo];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"我已经验证" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self refreshUserInfo];
    }];
    [vc addAction:cacleAction];
    [vc addAction:sureAction];
    [self.viewController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 刷新用户信息
- (void)refreshUserInfo{
    // 使用已知 objectId 构建一个 AVObject
    AVObject *anotherTodo = [AVObject objectWithClassName:@"_User" objectId:[ZMUserInfo shareUserInfo].userId];
    // 然后调用刷新的方法，将数据从云端拉到本地
    [anotherTodo fetchInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        // 此处调用 fetchInBackgroundWithBlock 和 refreshInBackgroundWithBlock 效果一样。
        NSLog(@"%@",object);
        //刷新用户资料
        [[ZMUserInfo shareUserInfo] updateUserInfo:object];
        [self.tableView reloadData];
    }];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        //更新用户签名
        [[AVUser currentUser] setObject:textView.text forKey:@"signature"];
        [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [MBProgressHUD showPromptMessage:@"更新资料成功"];
                [[ZMUserInfo shareUserInfo] loadUserInfo: [AVUser currentUser]];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KUpdateUserInfoNotice object:nil];
                [self.tableView reloadData];
            }
        }];
        
        return NO;
    }
    return YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
