//
//  ZXDCustromLayout.m
//  FootPrintFindPage
//
//  Created by 张雪东 on 16/4/18.
//  Copyright © 2016年 张雪东. All rights reserved.
//

#import "ZXDCustromLayout.h"

@interface ZXDCustromLayout()

@property (nonatomic,assign) CGFloat dragOffset;
@property (nonatomic,strong) NSMutableArray *layoutAttrArr;
@property (nonatomic,assign) NSInteger featureItemIndex;
@property (nonatomic,assign) CGFloat nextItemPercentageOffset;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) NSInteger numberOfItems;

@end

@implementation ZXDCustromLayout

-(CGFloat)dragOffset{

    return _featureCellHeight - _standCellHeight;
}

//存放每个item的attr
-(NSMutableArray *)layoutAttrArr{

    if (_layoutAttrArr == nil) {
        _layoutAttrArr = [NSMutableArray array];
    }
    return _layoutAttrArr;
}

//顶部cell的index
-(NSInteger)featureItemIndex{

    return MAX(0, (self.collectionView.contentOffset.y / self.dragOffset));
}

//返回一个比率(0~1) 设置即将放大cell的高
-(CGFloat)nextItemPercentageOffset{

    return (self.collectionView.contentOffset.y / self.dragOffset) - self.featureItemIndex;
}

-(CGFloat)width{

    return CGRectGetWidth(self.collectionView.bounds);
}

-(CGFloat)height{

    return CGRectGetHeight(self.collectionView.bounds);
}

-(NSInteger)numberOfItems{

    return [self.collectionView numberOfItemsInSection:0];
}

-(CGSize)collectionViewContentSize{

    CGFloat contentHeight = self.numberOfItems * self.dragOffset + self.height - self.dragOffset;
    return CGSizeMake(self.width, contentHeight);
}

-(void)prepareLayout{

    [self.layoutAttrArr removeAllObjects];
    
    CGRect frame = CGRectZero;
    CGFloat y = 0;
    
    for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:0]; item ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.zIndex = item;
        
        CGFloat height = self.standCellHeight;
        
        if (indexPath.item == self.featureItemIndex) {
            CGFloat yOffset = self.standCellHeight * self.nextItemPercentageOffset;
            y = self.collectionView.contentOffset.y - yOffset;
            height = self.featureCellHeight;
        }else if(indexPath.item == (self.featureItemIndex + 1) && indexPath.item != self.numberOfItems){
            CGFloat maxY = y + self.standCellHeight;
            height = self.standCellHeight + MAX((self.featureCellHeight - self.standCellHeight) * self.nextItemPercentageOffset, 0);
            y = maxY - height;
        }
        frame = CGRectMake(0, y, self.width, height);
        attributes.frame = frame;
        [self.layoutAttrArr addObject:attributes];
        y = CGRectGetMaxY(frame);
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *layoutAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in self.layoutAttrArr) {
        if (CGRectIntersectsRect(attr.frame, rect)) {
            [layoutAttributes addObject:attr];
        }
    }
    
    return layoutAttributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{

    NSInteger itemIndex  = round(proposedContentOffset.y / self.dragOffset);
    return CGPointMake(0, itemIndex * self.dragOffset);
}

@end
