//
//  KBGroupTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 16/3/10.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupSearchModel.h"
#import "KBGroupTableViewCell.h"

@interface KBGroupTableViewCell ()
@property (strong, nonatomic) UILabel* groupIdLabel;
@property (strong, nonatomic) UILabel* createrLabel;
@property (strong, nonatomic) UILabel* createDateLabel;
@property (strong, nonatomic) UIView* containerView;
@end

@implementation KBGroupTableViewCell

- (instancetype)initWithCellIdentifier:(NSString*)cellID
{
    if (self = [super initWithCellIdentifier:cellID]) {
        self.groupIdLabel = [UILabel new];
        self.createrLabel = [UILabel new];
        self.createDateLabel = [UILabel new];
        self.containerView = [UIView new];
        [self setBackgroundColor:[UIColor clearColor]];
        [self.containerView setBackgroundColor:[UIColor whiteColor]];
        [self.containerView.layer setCornerRadius:5.0f];
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.groupIdLabel];
        [self.containerView addSubview:self.createrLabel];
        [self.containerView addSubview:self.createDateLabel];
        [self configConstrains];
    }
    return self;
}

- (void)bindModel:(KBGroupSearchItem*)model
{
    self.groupIdLabel.attributedText = [[NSAttributedString alloc] initWithString:INT_TO_STIRNG(model.groupId)
                                                                       attributes:TITLE_ATTRIBUTE];
    self.createrLabel.attributedText = [[NSAttributedString alloc] initWithString:model.name attributes:TITLE_ATTRIBUTE];
    self.createDateLabel.attributedText = [[NSAttributedString alloc] initWithString:@"2016/12/12"
                                                                          attributes:SUBTITLE_ATTRIBUTE];
}

- (void)configConstrains
{
    [self.containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 0, 10)];
    [self.groupIdLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.groupIdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [self.createrLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.groupIdLabel withOffset:20.0f];
    [self.createrLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.groupIdLabel];
    [self.createDateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.createrLabel withOffset:20.0f];
    [self.createDateLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.createrLabel];
    [self updateConstraints];
}

+ (CGFloat)calculateCellHeightWithData:(id)cellData
{
    return 80;
}

@end
