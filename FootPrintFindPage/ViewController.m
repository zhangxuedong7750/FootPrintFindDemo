//
//  ViewController.m
//  FootPrintFindPage
//
//  Created by 张雪东 on 16/4/18.
//  Copyright © 2016年 张雪东. All rights reserved.
//

#import "ViewController.h"
#import "ZXDCustromLayout.h"
#import "FootPrintFindCell.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
static NSString *const reuseIndentifier = @"FootPrintFindCell";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZXDCustromLayout *layout = [[ZXDCustromLayout alloc] init];
    layout.standardCellHeight = 100.0;
    layout.featureCellHeight = 280.0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) collectionViewLayout:layout];
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[FootPrintFindCell class] forCellWithReuseIdentifier:reuseIndentifier];
    collectionView.prefetchingEnabled = NO; //ios10之后collectonview有预加载
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    FootPrintFindCell *cell = (FootPrintFindCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"Inspiration-%ld",(long)indexPath.item  + 1];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
