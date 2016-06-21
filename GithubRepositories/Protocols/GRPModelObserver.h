//
//  GRPModelObserver.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GRPModelObserver <NSObject>

@optional
- (void)modelDidLoad:(id)model;
- (void)modelDidFailToLoad:(id)model;
- (void)modelDidCancelLoading:(id)model;
- (void)modelDidUnload:(id)model;

@end
