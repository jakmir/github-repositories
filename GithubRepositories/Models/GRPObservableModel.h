//
//  GRPObservableModel.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRPObservableObject.h"
#import "GRPModelProtocol.h"

@interface GRPObservableModel : GRPObservableObject<GRPModelProtocol>

- (void)notifyObserversOfSuccessfulLoad;
- (void)notifyObserversOfFailedLoad;
- (void)notifyObserversOfCancelledLoad;
- (void)notifyObserversOfUnload;

@end
