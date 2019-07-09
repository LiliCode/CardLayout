//
//  UICollectionViewCardLayout.m
//  UICollectionViewCardLayout
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 Qiyue. All rights reserved.
//

#import "UICollectionViewCardLayout.h"
#import "UICollectionViewCardLayoutAttributes.h"

@implementation UICollectionViewCardLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = -150.0f;
    
    id <UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
//        CGSize itemSize = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
//        self.sectionInset = UIEdgeInsetsMake(0, itemSize.width + self.minimumLineSpacing, 0, itemSize.width + self.minimumLineSpacing);
        self.sectionInset = UIEdgeInsetsMake(0, fabs(self.minimumLineSpacing), 0, fabs(self.minimumLineSpacing));
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 获得super已经计算好的布局属性
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewCardLayoutAttributes *attribute in attributes) {
        // 计算collectionView最中心点的x值
        CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attribute.center.x - centerX);
        // 得到一個縮放比例
        CGFloat aprtScale = delta / self.collectionView.bounds.size.width / .68f;
        // 将cell的缩放范围规定到 -π/4 到 +π/4之间，并对它执行缩放操作
        CGFloat scale = ABS(cosf(aprtScale * M_PI_2));
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
        // 按照 item 的大小顯示，最大的顯示在最前面
        attribute.zIndex = -delta;
        // 漸變值，可以做顏色的漸變（爲了不使用 alpha 值）
        attribute.gradientValue = delta / (self.collectionView.frame.size.width * 0.5);
    }
    
    return attributes;
}


- (CGPoint )targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter_X = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes * attributes in array)
    {
        CGFloat itemHorizontalCenter_X = attributes.center.x;
        if (ABS(itemHorizontalCenter_X - horizontalCenter_X) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter_X - horizontalCenter_X;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

+ (Class)layoutAttributesClass {
    return UICollectionViewCardLayoutAttributes.class;
}

@end
