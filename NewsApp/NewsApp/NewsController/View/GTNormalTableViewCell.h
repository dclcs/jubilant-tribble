//
//  GTNormalTableViewCell.h
//  NewsApp
//
//  Created by dcl on 2021/5/6.
//

#import <UIKit/UIKit.h>
#import "GTListItem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GTNormalTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end


@interface GTNormalTableViewCell : UITableViewCell
-(void)layoutTableViewCellWithItem:(GTListItem *)item;
@property(nonatomic, weak, readwrite) id<GTNormalTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
