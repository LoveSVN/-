//
//  ViewController.m
//  滚动页面
//
//  Created by 张晓亮 on 2018/12/25.
//  Copyright © 2018 张晓亮. All rights reserved.
//

#import "ViewController.h"
#import "KLMyCommunityVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushNewVC:(UIButton *)sender {

    [self.navigationController pushViewController:KLMyCommunityVC.new animated:YES];
}

@end
