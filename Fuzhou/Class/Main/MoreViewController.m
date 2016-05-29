//
//  MoreViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "MoreViewController.h"
#import "AppInfo.h"
#import "AppView.h"

#define kAppviewW 80
#define kAppviewH 100
#define kColCount 3
#define kStartY 20

@interface MoreViewController ()<AppViewDelegate>
@property (nonatomic,strong)NSArray *appList;
@property (nonatomic,strong) UILabel *label;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrolView;

@end

@implementation MoreViewController

-(UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 80, self.view.center.y, 160, 40)];        _label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        _label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_label];
        
        _label.alpha = 0.0;
    }
    return _label;
}
- (NSArray *)appList
{
    if (_appList == nil) {
        /*
         字典转模型：
         数组中保存模型，可以自定义方法
         */
        
        _appList = [AppInfo applist];
    }
    return _appList;
}
//代理
-(void)appViewDidClickDownloadButton:(AppView *)appView
{
    // 添加UIlabel到界面
    self.label.text = appView.appInfo.name;
    
    
    // ^表示block，块代码，是一个预先准备好的代码块，可以当做参数传递，在需要时候执行
    
    // 动画开始，动画时间，动画结束动作
    [UIView animateWithDuration:1.0f animations:^{
        self.label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            self.label.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}
/*
 stroryborad 能够描述一个应用程序所有的界面
 xib 适合小块的图形界面
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     // xib测试代码
     // 加载:xib中可以包含多个自定义视图，通常只包含一个
     NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil];
     UIView *view = [array firstObject];
     */
    
    // 搭建九宫格-[算法]
    CGFloat marginX = (self.view.bounds.size.width - kColCount * kAppviewW) / (kColCount + 1);
    CGFloat marginY = 10;
    for (int i =  0; i < 12; i++) {
        int row = i / kColCount;
        int col = i % kColCount;
        CGFloat x = marginX + col * (marginX + kAppviewW);
        CGFloat y = marginY + row * (marginY + kAppviewH) + kStartY + 44;
        //        xib创建
        
        // 视图
        AppView *appView = [AppView appViewWithappInfo:self.appList[i]];
        
        appView.delegate = self;
        appView.frame = CGRectMake(x, y, kAppviewW, kAppviewH);
        [self.view addSubview:appView];
        
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
