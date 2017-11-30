//
//  LViewController.m
//  LBaseClass
//
//  Created by liqiang on 2017/11/29.
//  Copyright © 2017年 liqiang. All rights reserved.
//

#import "LViewController.h"

@interface LViewController ()

@end

@implementation LViewController

#pragma mark - Interface

- (instancetype)init {
    self = [super init];
    
    [self initialize];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self initialize];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    [self initialize];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.visibleNavbar) {
        if (self.navigationController && self.navigationController.navigationBar.hidden) {
            self.navigationController.navigationBar.hidden = NO;
        }
    } else {
        if (self.navigationController && !self.navigationController.navigationBar.hidden) {
            self.navigationController.navigationBar.hidden = YES;
        }
    }
    
    if (self.visibleTabar) {
        if (self.tabBarController && self.tabBarController.tabBar.hidden) {
            self.tabBarController.tabBar.hidden = NO;
        }
    } else {
        if (self.tabBarController && !self.tabBarController.tabBar.hidden) {
            self.tabBarController.tabBar.hidden = YES;
        }
    }
}

- (void)setVisibleNavbar:(BOOL)visibleNavbar {
    _visibleNavbar = visibleNavbar;
    
    if (_visibleNavbar) {
        if (self.navigationController && self.navigationController.navigationBar.hidden) {
            self.navigationController.navigationBar.hidden = NO;
        }
    } else {
        if (self.navigationController && !self.navigationController.navigationBar.hidden) {
            self.navigationController.navigationBar.hidden = YES;
        }
    }
}

- (void)setVisibleTabar:(BOOL)visibleTabar {
    _visibleTabar = visibleTabar;
    
    if (_visibleTabar) {
        if (self.tabBarController && self.tabBarController.tabBar.hidden) {
            self.tabBarController.tabBar.hidden = NO;
        }
    } else {
        if (self.tabBarController && !self.tabBarController.tabBar.hidden) {
            self.tabBarController.tabBar.hidden = YES;
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LInitProtocol

- (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.visibleNavbar = NO;
        self.visibleTabar = NO;
        
        self.uid = [NSUUID UUID].UUIDString;
        self.createTime = [[NSDate date] timeIntervalSince1970];
    });
}

@end
