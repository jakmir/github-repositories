//
//  GRPDataContext.m
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import "GRPDataContext.h"
#import "AFURLSessionManager.h"
#import "GRPGithubRepositoryModel.h"

static NSString *kGRPKeyItems = @"items";
static NSString *kGRPKeyLogin = @"login";
static NSString *kGRPKeyHtmlURL = @"html_url";
static NSString *kGRPKeyOwner = @"owner";
static NSString *kGRPKeyDescription = @"description";
static NSString *kGRPKeyStargazersCount = @"stargazers_count";
static NSString *kGRPKeyAvatarURL = @"avatar_url";

@interface GRPDataContext()

@property (nonatomic, strong) NSURLSessionDataTask      *sessionDataTask;

@property (nonatomic, strong) NSArray *repositories;
@end


@implementation GRPDataContext

#pragma mark - 
#pragma mark - Initializers

- (instancetype)initWithURLString:(NSString *)urlString {
    if (self = [super init]) {
        self.URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors and mutators

- (void)setSessionDataTask:(NSURLSessionDataTask *)sessionDataTask {
    if (_sessionDataTask == sessionDataTask) {
        return;
    }
    
    [_sessionDataTask cancel];
    _sessionDataTask = sessionDataTask;
    [_sessionDataTask resume];
}

- (NSArray *)items {
    return _repositories;
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    
    if (![super load]) {
        return NO;
    }
    
    NSURLRequest *request = self.URLRequest;
    if (!request.URL) {
        NSLog(@"URL is nil in DataContext");
        return NO;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionDataTask = [sessionManager dataTaskWithRequest:self.URLRequest
                                             completionHandler:^(NSURLResponse *response, NSData *responseObject, NSError *error)
                            {
                                if (error) {
                                    NSLog(@"%@", error);
                                    _errorReason = error.localizedDescription;
                                    [self failLoading];
                                } else {
                                    [self modelDidLoad:responseObject];
                                }
                                [sessionManager.session invalidateAndCancel];
                                self.sessionDataTask = nil;
                            }];
    
    return YES;
}

- (void)cancel {
    [self.sessionDataTask cancel];
    self.sessionDataTask = nil;
}

- (void)failLoading {
    [super failLoading];
}

- (void)modelDidLoad:(id)model {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:model options:0 error:nil];
    NSArray *items = json[kGRPKeyItems];
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *item in items) {
        id ownerObject = item[kGRPKeyOwner];
        id htmlUrlBoxed = item[kGRPKeyHtmlURL];
        NSString *htmlURL;
        if (!htmlUrlBoxed || htmlUrlBoxed == [NSNull null]) {
            htmlURL = @"https://github.com";
        } else {
            htmlURL = htmlUrlBoxed;
        }
        
        id descriptionBoxed = item[kGRPKeyDescription];
        NSString *description;
        if (!descriptionBoxed || descriptionBoxed == [NSNull null]) {
            description = @"Description not specified";
        } else {
            description = descriptionBoxed;
        }
        
        id stargazersCountBoxed = item[kGRPKeyStargazersCount];
        NSUInteger stargazersCount = 0;
        if (stargazersCountBoxed && stargazersCountBoxed != [NSNull null]) {
            stargazersCount = [stargazersCountBoxed unsignedIntegerValue];
        }
        
        if ([ownerObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *ownerDictionary = ownerObject;
            
            id avatarUrlBoxed = ownerDictionary[kGRPKeyAvatarURL];
            NSString *avatarURL;
            if (!avatarUrlBoxed || avatarUrlBoxed == [NSNull null]) {
                avatarURL = @"";
            }
            else {
                avatarURL = avatarUrlBoxed;
            }
            
            id loginBoxed = ownerDictionary[kGRPKeyLogin];
            NSString *login;
            if (!loginBoxed || loginBoxed == [NSNull null]) {
                login = @"anonymous";
            } else {
                login = loginBoxed;
            }
            
            GRPGithubRepositoryModel *githubRepoModel = [[GRPGithubRepositoryModel alloc] init];
            githubRepoModel.ownerAvatarUrl = [NSURL URLWithString:avatarURL];
            githubRepoModel.ownerLogin = login;
            githubRepoModel.repositoryDescription = description;
            githubRepoModel.stargazersCount = stargazersCount;
            githubRepoModel.htmlUrl = [NSURL URLWithString:htmlURL];
            [result addObject:githubRepoModel];
        }
    }
    
    self.repositories = [result copy];
    [self finishLoading];
    [self dump];
}
@end
