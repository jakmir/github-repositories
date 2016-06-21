//
//  GRPObservableObject.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRPObservableObject : NSObject

@property (nonatomic, readonly)	NSArray	*observers;

- (void)registerObserver:(id)observer;
- (void)unregisterObserver:(id)observer;

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector userInfo:(id)info;
- (void)notifyObserversWithSelector:(SEL)selector userInfo:(id)info error:(id)error;

@end
