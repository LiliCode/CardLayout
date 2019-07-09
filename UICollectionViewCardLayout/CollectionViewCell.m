//
//  CollectionViewCell.m
//  UICollectionViewCardLayout
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 Qiyue. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UICollectionViewCardLayoutAttributes.h"

@interface CollectionViewCell ()
@property (strong, nonatomic) UIView *dimmingView;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont boldSystemFontOfSize:24];
        [self addSubview:self.label];
        
        self.dimmingView = [[UIView alloc] initWithFrame:self.bounds];
        self.dimmingView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dimmingView];
        
        // 圓角
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10.0f;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
    self.dimmingView.frame = self.bounds;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    // 使用自定义布局对象调整 Cell 外观
//    NSLog(@"渐变值：%lg", [(UICollectionViewCardLayoutAttributes *)layoutAttributes gradientValue]);
    
    CGFloat gradientValue = [(UICollectionViewCardLayoutAttributes *)layoutAttributes gradientValue];
    
    self.dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:gradientValue];
    
    if (!(BOOL)[(UICollectionViewCardLayoutAttributes *)layoutAttributes gradientValue]) {
        NSLog(@"渐变值：%lg", gradientValue);
        if (self.didSelectCard) {
            self.didSelectCard(self.label.text);
        }
    }
}


@end
