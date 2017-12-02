//
//  LTextField.h
//  LBaseClass
//
//  Created by liqiang on 2017/11/30.
//  Copyright © 2017年 liqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LInitProtocol.h"

@interface LTextField : UITextField<LInitProtocol>

/**
 *  唯一标示
 */
@property (nonatomic, strong) NSString *uid;

/**
 *  创建时间
 */
@property (nonatomic, assign) NSTimeInterval createTime;

@end