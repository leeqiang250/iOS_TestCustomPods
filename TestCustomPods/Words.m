//
//  Words.m
//  TestCustomPods
//
//  Created by liqiang on 2018/8/22.
//  Copyright © 2018年 liqiang. All rights reserved.
//

#import "Words.h"

@interface Words() {
    NSMutableDictionary *_words;//助记词库
    NSInteger _wordsCount;//助记词库数量
    NSInteger _keysCount;//助记词长度
    
    NSMutableArray *_currentIndex;//当前索引
    NSArray *_startIndex;//起始索引
    NSArray *_stopIndex;
    
    uint64_t _count;
}

@end

@implementation Words

- (instancetype)init {
    self = [super init];
    _keysCount = 12;
    NSData *data = [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"words" ofType:@"txt"]];
    NSArray *words = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    _wordsCount = words.count;
    _words = [[NSMutableDictionary alloc] initWithCapacity:_wordsCount];
    for (NSInteger i = 0; i < _wordsCount; i++) [_words setObject:[words objectAtIndex:i] forKey:[NSString stringWithFormat:@"%ld", i]];
    
    
    //test
    //[[NSClassFromString(@"Words") alloc] init];
    [self setStartIndex:[self getFirstIndex]];
    [self setStopIndex:@"3,4,5,6,7,8,9,10,11,12,13,14"];
    if ([self isValid]) {
        [self start];
    }
    //test
    
    return self;
}

- (void)start {
    {
        uint64_t count = 1;
        uint64_t wordsCount = _wordsCount;
        for (NSInteger i = 0; i < _keysCount; i++) {
            count = count * wordsCount;
            wordsCount--;
        }
        NSLog(@"%llu", count);
    }
    
    _count = 0;
    while (YES) {
        [self fsdfd:_stopIndex];
    }
    
    while (YES) {
        NSLog(@"%@", [self getWords:_currentIndex]);
        if (![self next]) break;
    }
}

- (BOOL)fsdfd:(NSArray *)index {
    for (NSInteger i = 0; i < index.count; i++) {
        NSInteger v_i = ((NSString *)[index objectAtIndex:i]).integerValue;
        if (v_i > 0) {
            for (NSInteger j = 0; j < v_i; j++) {
                _count += (_wordsCount - 1) * (_wordsCount - 2) * (_wordsCount - 3) * (_wordsCount - 4) * (_wordsCount - 5) * (_wordsCount - 6) * (_wordsCount - 7) * (_wordsCount - 8) * (_wordsCount - 9) * (_wordsCount - 10) * (_wordsCount - 11);
            }
        }
        
        
        //v_i.integerValue
        
        
        uint64_t dd = _wordsCount;
        
        
        NSString *stop = [_stopIndex objectAtIndex:i];
        
        
    }
    
    
    return YES;
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
    for (NSString *key in keys) [words addObject:[_words objectForKey:key]];
    //return [words componentsJoinedByString:@" "];
    return [keys componentsJoinedByString:@","];
}
- (void)setStartIndex:(NSString *)index {
    NSArray *arrIndex = [index componentsSeparatedByString:@","];
    if (arrIndex.count != _keysCount) arrIndex = nil;
    _startIndex = arrIndex;
    _currentIndex = [_startIndex mutableCopy];
}
- (void)setStopIndex:(NSString *)index {
    NSArray *arrIndex = [index componentsSeparatedByString:@","];
    if (arrIndex.count != _keysCount) arrIndex = nil;
    _stopIndex = arrIndex;
}
- (BOOL)isValid {
    if (_startIndex.count != _keysCount || _stopIndex.count != _keysCount) return NO;
    
    BOOL state = NO;
    NSInteger count = _stopIndex.count;
    for (NSInteger i = 0; i < count; i++) {
        NSString *start = [_startIndex objectAtIndex:i];
        NSString *stop = [_stopIndex objectAtIndex:i];
        if (stop.integerValue > start.integerValue) {
            state = YES;
            break;
        }
    }
    
    return state;
}
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
