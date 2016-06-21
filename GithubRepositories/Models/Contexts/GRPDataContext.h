//
//  GRPDataContext.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRPObservableModel.h"
#import "GRPModelObserver.h"

@interface GRPDataContext : GRPObservableModel<GRPModelObserver>

@property (nonatomic, strong) NSURLRequest *URLRequest;

@property (nonatomic, readonly) NSString *errorReason;

@property (nonatomic, readonly) NSArray *items;
@property (nonatomic, readonly) NSString *errorString;

- (instancetype)initWithURLString:(NSString *)urlString;

@end
