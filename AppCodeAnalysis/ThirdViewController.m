//
//  ThirdViewController.m
//  AppCodeAnalysis
//
//  Created by ldh on 2019/1/17.
//  Copyright © 2019年 ldh. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedButton:(id)sender{
    UIViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
