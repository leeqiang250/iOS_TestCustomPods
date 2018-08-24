//
//  Words.h
//  TestCustomPods
//
//  Created by liqiang on 2018/8/22.
//  Copyright © 2018年 liqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Words : NSObject








- (void)start;
- (void)setStartIndex:(NSString *)index;
//- (void)setStopIndex:(NSString *)index;
//- (BOOL)isValid;

- (NSString *)getFirstIndex;
- (NSString *)getLastIndex;

@end
