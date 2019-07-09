//
//  ViewController.m
//  UICollectionViewCardLayout
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 Qiyue. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray<UIColor *> *colors;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
     
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    self.colors = [NSMutableArray new];
    for (NSInteger i = 0; i < 10; i++) {
        CGFloat red = arc4random() % 255 / 255.0f;
        CGFloat green = arc4random() % 255 / 255.0f;
        CGFloat blue = arc4random() % 255 / 255.0f;
        [self.colors addObject:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    });
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%lu", indexPath.row];

    cell.backgroundColor = [self.colors objectAtIndex:indexPath.row];
    
    cell.didSelectCard = ^(id  _Nonnull value) {
        self.titleLabel.text = [NSString stringWithFormat:@"Fuck!! => %@", value];
    };
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200.0f, 250.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    NSLog(@"點擊了當前的卡片：%lu", indexPath.row);
}

@end
