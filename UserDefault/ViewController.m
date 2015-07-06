//
//  ViewController.m
//  UserDefault
//
//  Created by MAEDA HAJIME on 2014/04/03.
//  Copyright (c) 2014年 MAEDA HAJIME. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    // NSUserDefaultsオブジェクト
    NSUserDefaults *_def;
    
}


@property (weak, nonatomic) IBOutlet UITextField *tfValInt;


@property (weak, nonatomic) IBOutlet UITextField *tfValString;


@property (weak, nonatomic) IBOutlet UIImageView *ivImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 準備処理
    [self doReady];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// キーボードのReturnボタンがタップされたらキーボードを閉じるようにする
// ※UITextFiledの以下デリゲートメソッドを実装する
// Did End On Exit
- (IBAction)doEndTextFiled:(id)sender {
    
    [self.tfValInt  resignFirstResponder];
    
    [self.tfValString  resignFirstResponder];
    
}

// 準備処理
- (void)doReady {
    
    // NSUserDefaultsオブジェクト生成
    _def = [NSUserDefaults standardUserDefaults];
    
    // 初期値の設定
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"999" forKey:@"INT01"];
        [dic setObject:@"Def" forKey:@"STR01"];
        [_def registerDefaults:dic];
    }
}


// キーボードのReturnボタンがタップされたらキーボードを閉じるようにする
// ※UITextFiledの以下デリゲートメソッドを実装する

- (IBAction)act:(id)sender {
    
    [self.tfValInt  resignFirstResponder];
    
    [self.tfValString  resignFirstResponder];
}

// [データ読込]ボタン押した時 readValue
- (IBAction)read:(id)sender {
    
    // データ読込（int）
    NSInteger bufInt = [_def integerForKey:@"INT01"];
    
    self.tfValString.text = [NSString stringWithFormat:
                             @"%ld", (long)bufInt]; // 32bit 64bit 対応long
    // データデータ読込（NSString）
    NSString *bufStr = [_def stringForKey:@"STR01"];
    self.tfValString.text = bufStr;
    
    // データ読込
    NSData *bufDat = [_def dataForKey:@"DAT01"];
    UIImage *bufImg = [UIImage imageWithData:bufDat];
    self.ivImage.image =bufImg;
    
}

// [データ保存]ボタン押した時 saveValue
- (IBAction)save:(id)sender {
    
    // データ保存（int） 型変換
    NSInteger bufInt = [self.tfValInt.text integerValue];
    [_def setInteger:bufInt forKey:@"INT01"];
    
    // データ保存（NSSTring）
    NSString *bufStr  = self.tfValString.text;
    [_def setObject:bufStr forKey:@"STR01"];
    
    // データ保存（NSData）
    UIImage *bufImg = [UIImage imageNamed:@"img01"];
    NSData *bufDat = UIImagePNGRepresentation(bufImg);
    [_def setObject:bufDat forKey:@"DAT01"];
    
    // 保存反映
    BOOL ret = [_def synchronize];
    NSLog(@"%@", ret ? @"保存確認":@"保存失敗");
    
}

// [削除]ボタン押した時 deleteValue
- (IBAction)delete:(id)sender {
    
//    // 個別削除
//    [_def removeObjectForKey:@"INT01"];
//    // 実行確定
//    [_def synchronize];
    
    // 一括削除
    NSString *bi = [[NSBundle mainBundle] bundleIdentifier];
    [_def removePersistentDomainForName:bi];
    
    // NSLog (@"削除");
}

@end
