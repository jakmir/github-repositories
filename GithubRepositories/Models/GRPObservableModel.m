//
//  GRPObservableModel.m
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import "GRPObservableModel.h"
#import "GRPModelObserver.h"

@interface GRPObservableModel()

@property (nonatomic) GRPModelState state;

@end

@implementation GRPObservableModel

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (self.state == GRPModelFinished) {
        [self notifyObserversOfSuccessfulLoad];
        return NO;
    }
    
    BOOL result = self.state != GRPModelLoading;
    self.state = GRPModelLoading;
    
    return result;
}

- (void)finishLoading {
    self.state = GRPModelFinished;
    [self notifyObserversOfSuccessfulLoad];
}

- (void)failLoading {
    self.state = GRPModelFailed;
    [self cleanup];
    [self notifyObserversOfFailedLoad];
}

- (void)cancel {
    if (self.state != GRPModelLoading) {
        return;
    }
    self.state = GRPModelCancelled;
    [self cleanup];
    [self notifyObserversOfCancelledLoad];
}

- (void)dump {
    if (self.state != GRPModelUnloaded) {
        return;
    }
    
    self.state = GRPModelUnloaded;
    [self cleanup];
    [self notifyObserversOfUnload];
}

- (void)cleanup {
}

#pragma mark -
#pragma mark Notifying methods

- (void)notifyObserversOfSuccessfulLoad {
    [self notifyObserversWithSelector:@selector(modelDidLoad:)];
}

- (void)notifyObserversOfFailedLoad {
    [self notifyObserversWithSelector:@selector(modelDidFailToLoad:)];
}

- (void)notifyObserversOfCancelledLoad {
    [self notifyObserversWithSelector:@selector(modelDidCancelLoading:)];
}

- (void)notifyObserversOfUnload {
    [self notifyObserversWithSelector:@selector(modelDidUnload:)];
}
@end
