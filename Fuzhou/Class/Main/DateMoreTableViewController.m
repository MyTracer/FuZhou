//
//  DateMoreTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateMoreTableViewController.h"
#import "SubTable.h"
#import "MBProgressHUD.h"
#import "DayTableViewController.h"

@interface DateMoreTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbbdname;
@property (weak, nonatomic) IBOutlet UITextView *tvinfonote;
@property (weak, nonatomic) IBOutlet UITextView *tvremark;
@property (nonatomic,strong)MBProgressHUD *hud;

@end

@implementation DateMoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbbdname.text = self.subData.bdname;
    self.tvinfonote.text = self.subData.infonote;
    self.tvremark.text = self.subData.remark;
    
    
    self.tvinfonote.contentInset = UIEdgeInsetsMake(8.f, 0.f, -8.f, 0.f);
    self.tvremark.contentInset = UIEdgeInsetsMake(8.f, 0.f, -8.f, 0.f);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.hud hideAnimated:YES];
}

// 相关提示
- (void)tellBackwithText:(NSString *)text withPic:(NSString *)pic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        self.hud  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the custom view mode to show any view.
        self.hud.mode = MBProgressHUDModeCustomView;
        // Set an image view with a checkmark.
        UIImage *image = [[UIImage imageNamed:pic] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        self.hud.square = YES;
        // Optional label text.
        self.hud.label.text = NSLocalizedString(text, @"HUD done title");
        
        [self.hud hideAnimated:YES afterDelay:1.f];
    });
}
- (IBAction)okclick:(id)sender {
    DayTableViewController *dc = [[DayTableViewController alloc] init];
    UINavigationController *dev = [self.tabBarController.viewControllers objectAtIndex:0];
    [dev popToRootViewControllerAnimated:NO];
    dc = (DayTableViewController *)dev.topViewController;
//    dc = (DayTableViewController *)dec;
    dc.idStr = self.subData.bdid;
    dc.dateStr = self.subData.date;
    self.tabBarController.selectedIndex = 0;
}


@end
