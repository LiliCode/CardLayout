//
//  UICollectionViewCardLayoutAttributes.m
//  UICollectionViewCardLayout
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019 Qiyue. All rights reserved.
//

#import "UICollectionViewCardLayoutAttributes.h"

@implementation UICollectionViewCardLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    UICollectionViewCardLayoutAttributes *layoutAttribute = [super copyWithZone:zone];
    layoutAttribute.gradientValue = self.gradientValue;
    return layoutAttribute;
}

@end
