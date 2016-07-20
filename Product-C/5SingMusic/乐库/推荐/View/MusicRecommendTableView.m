//
//  MusicRecommendTableView.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicRecommendTableView.h"
#import "CarouselView.h"
#import "MusicOfDayTableViewCell.h"
#import "MusicOfTjGeDanCollectionView.h"
#import "MusicOfTjLiveCollectionView.h"
#import "MusicOfTjItemsTableViewCell.h"

@interface MusicRecommendTableView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate>

@end

@implementation MusicRecommendTableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame style:(UITableViewStylePlain)];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:@"reloadTableView" object:nil];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
        [self registerNib:[UINib nibWithNibName:@"MusicOfDayTableViewCell" bundle:nil] forCellReuseIdentifier:@"TjDay"];
        [self registerNib:[UINib nibWithNibName:@"MusicOfTjItemsTableViewCell" bundle:nil] forCellReuseIdentifier:@"TjItems"];
    }
    return self;
}

- (void)reloadTableView:(NSNotification *)notification {
    NSString *object = notification.object;
    NSNumber *objectNum = [[[NSNumberFormatter alloc] init] numberFromString:object];
    NSInteger index = [objectNum integerValue];
    [self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return self.modelArrayOfTjItems.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createScrollViewWithSuperView:cell];
            return cell;
        }
        case 1: {
            MusicOfDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TjDay" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell cellConfiguredByModel:self.modelArrayOfTjDAY[indexPath.row]];
            return cell;
        }
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.modelArrayOfTjGeDan) {
                MusicOfTjGeDanCollectionView *tjGeDanCollectionView = [[MusicOfTjGeDanCollectionView alloc] initWithFrame:cell.bounds modelArray:self.modelArrayOfTjGeDan];
                tjGeDanCollectionView.delegate = self;
                [cell.contentView addSubview:tjGeDanCollectionView];
            }
            return cell;
        }
        case 3: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.modelArrayOfTjLive) {
                MusicOfTjLiveCollectionView *tjLiveCollectionView = [[MusicOfTjLiveCollectionView alloc] initWithFrame:cell.bounds modelArray:self.modelArrayOfTjLive];
                [cell.contentView addSubview:tjLiveCollectionView];
            }
            return cell;
        }
        case 4: {
            MusicOfTjItemsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TjItems" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell cellConfiguredByModel:self.modelArrayOfTjItems[indexPath.row]];
            return cell;
        }
        default: return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return KRealValue(150);
        case 1: return KRealValue(130);
        case 2: return KRealValue((KScreenW-30)/3 + 10);
        case 3: return KRealValue((KScreenW-30)/3 + 10);
        case 4: return 44;
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return 0;
        default: return KRealValue(30);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KRealValue(30))];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = KColor(26, 179, 0);
    label.font = [UIFont systemFontOfSize:19];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(10);
        make.centerY.equalTo(headerView.mas_centerY).centerOffset(CGPointMake(0, 5));
    }];
    switch (section) {
        case 0: return nil;
        case 1: {
            label.text = @"每日推荐";
            return headerView;
        }
        case 2: {
            label.text = @"推荐歌单";
            return headerView;
        }
        case 3: {
            label.text = @"LIVE直播";
            return headerView;
        }
        case 4: {
            label.text = @"专题";
            return headerView;
        }
        default: return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            ModelOfTjDAY *model = self.modelArrayOfTjDAY[indexPath.row];
            self.DayPush([NSString stringWithFormat:@"%@", model.Type], [NSString stringWithFormat:@"%@", model.Id]);
            break;
        }
        case 4: {
            ModelOfTjItems *model = self.modelArrayOfTjItems[indexPath.row];
            self.ItemsPush(model.Url, model.Title);
            break;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.GeDanPush(indexPath.row);
}

// 创建推荐广告栏
- (void)createScrollViewWithSuperView:(UITableViewCell *)cell {
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (ModelOfTjADV *model in self.modelArrayOfTjADV) {
        [imageUrls addObject:model.ImgUrl];
    }
    CarouselView *carouselView = [[CarouselView alloc] initWithFrame:cell.bounds imageURLs:imageUrls];
    carouselView.imageClick = ^(NSInteger index) {
        self.AdvPush(index);
    };
    [cell.contentView addSubview:carouselView];
}

@end
