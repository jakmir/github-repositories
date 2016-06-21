//
//  GRPGithubRepositoryModel.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRPGithubRepositoryModel : NSObject

@property (nonatomic, strong) NSString *ownerLogin;
@property (nonatomic, strong) NSURL *ownerAvatarUrl;
@property (nonatomic ,strong) NSString *repositoryDescription;
@property (nonatomic) NSUInteger stargazersCount;
@property (nonatomic, strong) NSURL *htmlUrl;

@end
