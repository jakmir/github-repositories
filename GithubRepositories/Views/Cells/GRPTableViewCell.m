//
//  GRPTableViewCell.m
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import "GRPTableViewCell.h"
#import "GRPGithubRepositoryModel.h"

@implementation GRPTableViewCell

- (IBAction)buttonClicked:(UIButton *)sender forEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(tableViewCellButtonClicked:)]) {
        [self.delegate tableViewCellButtonClicked:self];
    }
}

- (void)fillWithModel:(GRPGithubRepositoryModel *)model {
    [self.labelDescription setText:model.repositoryDescription];
    [self.labelDescription sizeToFit];
    
    [self.avatarImageView setImageWithURL:model.ownerAvatarUrl
                         placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    NSString *title = model.htmlUrl.absoluteString;
    [self.buttonHtmlUrl setTitle:title forState:UIControlStateNormal];
    [self.buttonHtmlUrl setTitle:title forState:UIControlStateHighlighted];
    
    [self.labelOwnerLogin setText:model.ownerLogin];
    [self.labelStargazersCount setText:[@(model.stargazersCount) stringValue]];
}

@end
