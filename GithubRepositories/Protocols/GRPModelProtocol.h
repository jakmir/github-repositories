//
//  GRPModelProtocol.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GRPModelReady,
    GRPModelLoading,
    GRPModelFinished,
    GRPModelFailed,
    GRPModelCancelled,
    GRPModelUnloaded
} GRPModelState;

@protocol GRPModelProtocol <NSObject>

@optional

@property (nonatomic, readonly) NSArray *observers;
@property (nonatomic, readonly) GRPModelState   state;

- (BOOL)load;
- (void)finishLoading;
- (void)failLoading;
- (void)cancel;
- (void)dump;
- (void)cleanup;

@end
