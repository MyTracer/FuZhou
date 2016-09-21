//
//  MessageDetailTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/15.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "MessageDetailTableViewController.h"
#import "MessageDataModel.h"

@interface MessageDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbbdname;
@property (weak, nonatomic) IBOutlet UILabel *lbdate;
@property (weak, nonatomic) IBOutlet UITextView *tvinfonote;

@end

@implementation MessageDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.lbbdname.text = self.detailData.bdname;
    self.lbdate.text = self.detailData.date;
    self.tvinfonote.text = self.detailData.infonote;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
