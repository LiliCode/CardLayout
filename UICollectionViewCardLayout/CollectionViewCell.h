//
//  CollectionViewCell.h
//  UICollectionViewCardLayout
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 Qiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) void (^didSelectCard)(id value);


@end

NS_ASSUME_NONNULL_END
