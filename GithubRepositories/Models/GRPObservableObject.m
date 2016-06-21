//
//  GRPObservableObject.m
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import "GRPObservableObject.h"

@interface GRPObservableObject()

@property (nonatomic, strong) NSMutableArray *mutableObservers;

@end

@implementation GRPObservableObject

- (id)init {
    self = [super init];
    if (self) {
        self.mutableObservers = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    return [self.mutableObservers copy];
}

#pragma mark -
#pragma mark - Public

- (void)registerObserver:(id)observer {
    if (![self.mutableObservers containsObject:observer]) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)unregisterObserver:(id)observer {
    [self.mutableObservers removeObject:observer];
}

- (void)notifyObserversWithSelector:(SEL)selector {
    for (id observer in self.mutableObservers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self];
        }
    }
}

- (void)notifyObserversWithSelector:(SEL)selector userInfo:(id)info {
    for (id observer in self.mutableObservers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:info];
        }
    }
}

- (void)notifyObserversWithSelector:(SEL)selector userInfo:(id)info error:(id)error {
    for (id observer in self.mutableObservers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:info withObject:error];
        }
    }
}

@end
