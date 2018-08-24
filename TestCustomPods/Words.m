//
//  Words.m
//  TestCustomPods
//
//  Created by liqiang on 2018/8/22.
//  Copyright © 2018年 liqiang. All rights reserved.
//

#import "Words.h"

@interface Words() {
    NSArray *_words;
    NSInteger _wordsCount;
    NSInteger _keysCount;
    
    NSMutableArray *_currentIndex;
    NSArray *_startIndex;
    NSArray *_stopIndex;
}

@end

@implementation Words

- (instancetype)init {
    self = [super init];

    NSData *data = [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"words" ofType:@"txt"]];
    _words = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    _wordsCount = _words.count;
    _keysCount = 12;
    
    return self;
}


- (void)start {
    while (YES) {
        NSLog(@"%@", [self getWords:_currentIndex]);
        if (![self next]) break;
    }
}
- (NSArray *)next {
    NSString *keyLast = _currentIndex.lastObject;
    NSInteger index = keyLast.integerValue + 1;
    if (index < _wordsCount) {
        [_currentIndex removeObjectAtIndex:_keysCount - 1];
        [_currentIndex addObject:[NSString stringWithFormat:@"%ld", index]];
        return _currentIndex;
    }else {
        
    }
    
    return nil;
}
- (NSString *)getWords:(NSArray *)keys {
    NSMutableArray *words = [[NSMutableArray alloc] initWithCapacity:keys.count];
    for (NSString *key in keys) [words addObject:[_words objectAtIndex:key.integerValue]];
    //return [words componentsJoinedByString:@" "];
    return [keys componentsJoinedByString:@","];
}
- (void)setStartIndex:(NSString *)index {
    NSArray *arrIndex = [index componentsSeparatedByString:@","];
    if (arrIndex.count != _keysCount) arrIndex = nil;
    _startIndex = arrIndex;
    _currentIndex = [_startIndex mutableCopy];
}
//- (void)setStopIndex:(NSString *)index {
//    NSArray *arrIndex = [index componentsSeparatedByString:@","];
//    if (arrIndex.count != _keysCount) arrIndex = nil;
//    _stopIndex = arrIndex;
//}
//- (BOOL)isValid {
//    if (_startIndex.count != _keysCount || _stopIndex.count != _keysCount) return NO;
//
//    BOOL state = NO;
//    NSInteger count = _stopIndex.count;
//    for (NSInteger i = 0; i < count; i++) {
//        NSString *start = [_startIndex objectAtIndex:i];
//        NSString *stop = [_stopIndex objectAtIndex:i];
//        if (stop.integerValue > start.integerValue) {
//            state = YES;
//            break;
//        }
//    }
//
//    return state;
//}
- (NSString *)getFirstIndex {
    NSMutableArray *index = [[NSMutableArray alloc] initWithCapacity:_keysCount];
    for (NSInteger i = 0; i < _keysCount; i++) [index addObject:[NSString stringWithFormat:@"%ld", i]];
    return [index componentsJoinedByString:@","];
}
- (NSString *)getLastIndex {
    NSInteger count = _wordsCount;
    NSMutableArray *index = [[NSMutableArray alloc] initWithCapacity:_keysCount];
    for (NSInteger i = (count - _keysCount); i < count; i++) [index addObject:[NSString stringWithFormat:@"%ld", i]];
    return [index componentsJoinedByString:@","];
}

@end
