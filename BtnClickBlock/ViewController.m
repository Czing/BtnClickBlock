//
//  ViewController.m
//  BtnClickBlock
//
//  Created by Cyzing on 16/9/6.
//  Copyright © 2016年 Cyzing. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+cyz_targetBlock.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    
    //    btn.btnClickType = cyz_UIControlEventTouchDown;//此属性设置后，只触发该属性
    
    [btn cyz_targetBlock:^(UIButton *btn,cyz_UIControlEventBtnType btnClickType) {
        switch (btnClickType) {
            case cyz_UIControlEventTouchUpInside:
                NSLog(@"cyz_UIControlEventTouchUpInside");
                break;
            case cyz_UIControlEventTouchDown:
                NSLog(@"cyz_UIControlEventTouchDown");
                break;
            case cyz_UIControlEventTouchUpOutside:
                NSLog(@"cyz_UIControlEventTouchUpOutside");
                break;
            case cyz_UIControlEventTouchCancel:
                NSLog(@"cyz_UIControlEventTouchCancel");
                break;
                
            default:
                break;
        }
        
    }];
    
}

@end
