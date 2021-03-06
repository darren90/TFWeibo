//
//  WBStatusPicturesView.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/23.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusPicturesView.h"
#import "WBStatusPictureCell.h"
#import "MLPictureBrowser.h"
#import "PictureModel.h"

#define KStatusPhotoWH 80
#define KStatusPhotoMargin 10
#define KStatusPhotoMaxCol(count) ((count == 4) ? 2 :3)


@interface WBStatusPicturesView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;

@property (nonatomic,weak)UICollectionView * waterView;
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation WBStatusPicturesView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        self.layout = layout;
        UICollectionView * waterView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        self.waterView = waterView;
        [self addSubview:waterView];
        [waterView registerNib:[UINib nibWithNibName:@"WBStatusPictureCell" bundle:nil] forCellWithReuseIdentifier:@"WBStatusPicture"];
        waterView.dataSource = self;
        waterView.delegate = self;
        waterView.backgroundColor = [UIColor whiteColor];
        waterView.scrollEnabled = NO;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.waterView.frame = self.bounds;
    self.layout.itemSize = CGSizeMake(KStatusPhotoWH, KStatusPhotoWH);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
}
 

+(CGSize )photosSizeWithCount:(NSInteger)count
{
    //最大列数
    int maxCols = KStatusPhotoMaxCol(count);;
    
    //列数
    int cols = count > 2 ? maxCols : count;
    CGFloat photoW = cols * KStatusPhotoWH + (cols -1)*KStatusPhotoMargin;
    
    
    //行数
    int rows = (count + maxCols - 1) / maxCols;//3是最大列数
    CGFloat photoH = rows * KStatusPhotoWH + (rows -1)*KStatusPhotoMargin;
    
    return CGSizeMake(photoW, photoH);
}


-(void)setPictures:(NSArray *)pictures
{
    _pictures = pictures;
    
    if (pictures) {
        self.dataArray = pictures;
        [self.waterView reloadData];
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WBStatusPicture" forIndexPath:indexPath];
    cell.pic = self.dataArray[indexPath.item];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLPictureBrowser *picBroser = [[MLPictureBrowser alloc]init];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.dataArray.count];
    for (PictureModel *pic in self.dataArray) {
        [array addObject:pic.thumbnail_pic];
    }
    [picBroser showWithPictureURLs:array atIndex:indexPath.item];
}
 

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

 
@end





