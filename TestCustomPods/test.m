//
//  test.m
//  VCash
//
//  Created by liqiang on 2018/8/23.
//  Copyright © 2018年 Kcash. All rights reserved.
//

#import "test.h"
#import "VCBIP44Tool.h"

@implementation test

- (instancetype)init {
    self = [super init];
    [self start];
    return self;
}

- (void)start {    
    NSString *key = [VCBIP44Tool.sharedVCBIP44Tool generatePhraseWithPassword:nil];
    NSArray *coins = [NSArray arrayWithObjects:@(BTC), @(ETH), @(ACT), @(LTC), @(GXS), @(EOS), nil];
    NSMutableDictionary *infos = [[NSMutableDictionary alloc] initWithCapacity:coins.count];
    for (NSNumber *coin in coins) {
        CoinType cointype = (CoinType)coin.shortValue;
        [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:cointype out:^(NSString *privateKey, NSString *address) {
            NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:privateKey, @"p", address, @"a", nil];
            [infos setObject:info forKey:[NSString stringWithFormat:@"%d", cointype]];
        }];
    }
    
    //BTC,BCH
    [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:BTC out:^(NSString *privateKey, NSString *address) {
        NSLog(@"%@_%@", privateKey, address);
    }];
    //ETH,ETC
    [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:ETH out:^(NSString *privateKey, NSString *address) {
        NSLog(@"%@_%@", privateKey, address);
    }];
    //ACT
    [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:ACT out:^(NSString *privateKey, NSString *address) {
        NSLog(@"%@_%@", privateKey, address);
    }];
    //LTC
    [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:LTC out:^(NSString *privateKey, NSString *address) {
        NSLog(@"%@_%@", privateKey, address);
    }];
    //GXS
    [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:GXS out:^(NSString *privateKey, NSString *address) {
        NSLog(@"%@_%@", privateKey, address);
    }];
    //EOS
    [VCBIP44Tool.sharedVCBIP44Tool ImportPhrase:key withPassword:nil CoinTye:EOS out:^(NSString *privateKey, NSString *address) {
        NSLog(@"%@_%@", privateKey, address);
    }];

    
}

@end
