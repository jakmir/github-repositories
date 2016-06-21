//
//  GRPTableViewCell.h
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "GRPTableViewCellProtocol.h"

@class GRPGithubRepositoryModel;

@interface GRPTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UIButton *buttonHtmlUrl;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelOwnerLogin;
@property (strong, nonatomic) IBOutlet UILabel *labelStargazersCount;

@property (weak, nonatomic) id<GRPTableViewCellProtocol> delegate;

- (void)fillWithModel:(GRPGithubRepositoryModel *)model;

@end
