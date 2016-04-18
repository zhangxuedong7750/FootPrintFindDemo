//
//  FootPrintFindCell.m
//  FootPrintFindPage
//
//  Created by 张雪东 on 16/4/18.
//  Copyright © 2016年 张雪东. All rights reserved.
//

#import "FootPrintFindCell.h"

@interface FootPrintFindCell()

@property (nonatomic,strong) UIView *corverView;

@end

@implementation FootPrintFindCell

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}

-(void)initView{

    self.clipsToBounds = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 280)];
    imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIView *corverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 280)];
    corverView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    corverView.backgroundColor = [UIColor blackColor];
    self.corverView = corverView;
    [self addSubview:corverView];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{

    [super applyLayoutAttributes:layoutAttributes];
    self.imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat standardCellHeight = 100.0;
    CGFloat featureCellHeight = 280.0;
    CGFloat delta = 1 - ((featureCellHeight - CGRectGetHeight(self.frame)) / (featureCellHeight - standardCellHeight));
    
    CGFloat minAlpha = 0;
    CGFloat maxAlpha = 0.5;
    self.corverView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    self.corverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha));
}

@end
