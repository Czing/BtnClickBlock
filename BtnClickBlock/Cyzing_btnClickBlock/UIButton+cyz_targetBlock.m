//
//  UIButton+cyz_targetBlock.m
//  test
//
//  Created by Cyzing on 16/9/5.
//  Copyright © 2016年 Cyzing. All rights reserved.
//

#import "UIButton+cyz_targetBlock.h"

const  char   completionKey;

@implementation UIButton (cyz_targetBlock)


-(void)cyz_targetBlock:(void(^)(UIButton * btn ,cyz_UIControlEventBtnType  btnClickType))completionHandler{

    UIButton *btn = (UIButton *)self;
    if (self.btnClickType==0) {
        [btn addTarget:self action:@selector(completeTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(completeTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [btn addTarget:self action:@selector(completeEventTouchDown:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(completeEventTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    }else{
        switch (self.btnClickType) {
            case cyz_UIControlEventTouchUpInside:
                [self addTarget:self action:@selector(completeTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case cyz_UIControlEventTouchDown:
                [self addTarget:self action:@selector(completeEventTouchDown:) forControlEvents:UIControlEventTouchDown];
                break;
            case cyz_UIControlEventTouchUpOutside:
                [self addTarget:self action:@selector(completeTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
                break;
            case cyz_UIControlEventTouchCancel:
                [self addTarget:self action:@selector(completeEventTouchCancel:) forControlEvents:UIControlEventTouchCancel];
                break;
            default:
                break;
        }
    }
    if (completionHandler!=nil) {
        objc_setAssociatedObject(self, &completionKey, completionHandler, OBJC_ASSOCIATION_COPY);
    }
}
-(void)setBtnClickType:(cyz_UIControlEventBtnType )btnClickType{
    
    objc_setAssociatedObject(self, @selector(btnClickType), @(btnClickType), OBJC_ASSOCIATION_ASSIGN);
}

-(cyz_UIControlEventBtnType  )btnClickType{
    
    return [objc_getAssociatedObject(self, _cmd)intValue];
}

-(void)completeTouchUpInside:(UIButton *)btn{
    
    [self complete:btn btnClickType:cyz_UIControlEventTouchUpInside];
}
-(void)completeTouchUpOutside:(UIButton *)btn{
    
     [self complete:btn btnClickType:cyz_UIControlEventTouchUpOutside];
}
-(void)completeEventTouchDown:(UIButton *)btn{
    
     [self complete:btn btnClickType:cyz_UIControlEventTouchDown];
}
-(void)completeEventTouchCancel:(UIButton *)btn{
    
    [self complete:btn btnClickType:cyz_UIControlEventTouchCancel];
}

-(void)complete:(UIButton *)btn btnClickType:(cyz_UIControlEventBtnType )btnClickType{

    void(^completionHandler)(UIButton *btn ,cyz_UIControlEventBtnType  btnClickType) = objc_getAssociatedObject(self, &completionKey);
    if (completionHandler ==nil) {
        return;
    }
    completionHandler(btn,btnClickType);
}

+(void)load{
    SEL  sys_SEL = @selector(addTarget:action:forControlEvents:);
    SEL  add_SEL = @selector(cyz_addTarget:action:forControlEvents:);
    Method  sys_Method = class_getInstanceMethod([self class],sys_SEL);
    Method  add_Method =class_getInstanceMethod([self class],add_SEL);
    BOOL  isAdd_Method = class_addMethod(self, sys_SEL, method_getImplementation(add_Method), method_getTypeEncoding(add_Method));
    if (isAdd_Method) {
        class_replaceMethod(self,add_SEL, method_getImplementation(sys_Method), method_getTypeEncoding(sys_Method));
    }else{
        method_exchangeImplementations(sys_Method, add_Method);
    }
}

-(void)cyz_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    if (self.btnClickType==0){
        [self cyz_addTarget:target action:action forControlEvents:controlEvents];
        return;
    }
    switch (self.btnClickType) {
        case cyz_UIControlEventTouchUpInside:
            [self cyz_addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            break;
        case cyz_UIControlEventTouchDown:
            [self cyz_addTarget:self action:action forControlEvents:UIControlEventTouchDown];
            break;
        case cyz_UIControlEventTouchUpOutside:
            [self cyz_addTarget:self action:action forControlEvents:UIControlEventTouchUpOutside];
            break;
        case cyz_UIControlEventTouchCancel:
            [self cyz_addTarget:self action:action forControlEvents:UIControlEventTouchCancel];
            break;
        default:
            break;
    }
}

@end
