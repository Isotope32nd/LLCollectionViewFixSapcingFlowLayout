//
//  ViewController.m
//  LLCollectionViewFixSapcingFlowLayout
//
//  Created by Totin on 2018/7/20.
//  Copyright © 2018年 LLTech. All rights reserved.
//

#import "ViewController.h"

#import "LLCollectionViewFixSapcingFlowLayout.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LLCollectionViewFixSapcingFlowLayout *layout = self.collectionView.collectionViewLayout;
    layout.cellAlignment = LLFixSapcingLayoutCellAlignmentCenter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *testCellId = @"testCellId";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:testCellId forIndexPath:indexPath];
    
    double red = arc4random() % 255 / 255.0f;
    double green = arc4random() % 255 / 255.0f;
    double blue = arc4random() % 255 / 255.0f;
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = 50 + arc4random() % 50;
    
    return CGSizeMake(width, 50);
}

@end
