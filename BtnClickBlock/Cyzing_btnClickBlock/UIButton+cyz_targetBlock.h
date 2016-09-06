//
//  UIButton+cyz_targetBlock.h
//  test
//
//  Created by Cyzing on 16/9/5.
//  Copyright © 2016年 Cyzing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef enum {
    cyz_UIControlEventTouchUpInside                 = 1,   // Default
    cyz_UIControlEventTouchDown                     = 2,
    cyz_UIControlEventTouchUpOutside                = 3,
    cyz_UIControlEventTouchCancel                   = 4
    
    /*
     //可以自定义添加枚举方法
     ............
*/
    
}cyz_UIControlEventBtnType;


@interface UIButton (cyz_targetBlock)

/**
 *  此属性若设置则只触发该属性方法
 */
@property(nonatomic,assign)cyz_UIControlEventBtnType   btnClickType;

-(void)cyz_targetBlock:(void(^)(UIButton * btn , cyz_UIControlEventBtnType  btnClickType))completionHandler;


@end
