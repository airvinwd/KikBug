//
//  KBBaseTableViewCell.h
//  KikBug
//
//  Created by DamonLiu on 16/3/9.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBBaseTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *rightArrow;
/**
 *  Override to bind model for cell
 *
 *  @param model Model
 */
- (void)bindModel:(id)model;
+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView;
- (id)initWithCellIdentifier:(NSString *)cellID;
+ (CGFloat)calculateCellHeightWithData:(id)cellData;
+ (CGFloat)calculateCellHeightWithData:(id)cellData containerWidth:(CGFloat)containerWidth;
+ (CGFloat)cellHeight;
- (void)configConstrains;

/**
 *  Override to custom subviews
 *
 *  @param model Model
 */
- (void)configSubviews;
@end
