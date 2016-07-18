//
//  MusicOfTjLiveCollectionView.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicOfTjLiveCollectionView.h"
#import "MusicOfTjLiveCollectionViewCell.h"

@interface MusicOfTjLiveCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation MusicOfTjLiveCollectionView

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSMutableArray *)modelArray {
    self = [super initWithFrame:frame collectionViewLayout:[self createLayout]];
    if (self) {
        self.modelArray = modelArray;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"MusicOfTjLiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TjLive"];
    }
    return self;
}

- (UICollectionViewFlowLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize = CGSizeMake((KScreenW-30)/3, (KScreenW-30)/3);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicOfTjLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TjLive" forIndexPath:indexPath];
    [cell cellConfiguredByModel:self.modelArray[indexPath.row]];
    return cell;
}


@end
