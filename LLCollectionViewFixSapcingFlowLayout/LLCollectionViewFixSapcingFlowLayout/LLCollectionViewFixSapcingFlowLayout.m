//
//  LLCollectionViewFixSapcingFlowLayout.m
//  LLCollectionViewEqualSpacingFlowLayout
//
//  Created by Totin on 2018/7/6.
//  Copyright © 2018年 Totin. All rights reserved.
//

#import "LLCollectionViewFixSapcingFlowLayout.h"

@implementation LLCollectionViewFixSapcingFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical && self.cellAlignment != LLFixSapcingLayoutCellAlignmentFlow) {
        NSMutableArray *tempCellAttributesArray = [NSMutableArray array];
        for (int i = 0; i < attributesArray.count; i++) {
            UICollectionViewLayoutAttributes *attributes = attributesArray[i];
            if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                NSLog(@"cellFrame : %@", [NSValue valueWithCGRect:attributes.frame]);
                [tempCellAttributesArray addObject:attributes];
                
            }
        }
        
        if (self.cellAlignment == LLFixSapcingLayoutCellAlignmentLeft) {
            
            for (int j = 1; j < tempCellAttributesArray.count; j++) {
                UICollectionViewLayoutAttributes *currentAttributes = tempCellAttributesArray[j];
                UICollectionViewLayoutAttributes *lastAttributes = tempCellAttributesArray[j - 1];
                if (currentAttributes.frame.origin.y == lastAttributes.frame.origin.y) {
                    CGRect frame = currentAttributes.frame;
                    frame.origin.x = CGRectGetMaxX(lastAttributes.frame) + self.fixSpacing;
                    currentAttributes.frame = frame;
                }
            }
        } else if (self.cellAlignment == LLFixSapcingLayoutCellAlignmentRight) {
            
            //先处理最后一个的frame
            UICollectionViewLayoutAttributes *lastOneAttributes = [tempCellAttributesArray lastObject];
            CGRect lastOneFrame = lastOneAttributes.frame;
            lastOneFrame.origin.x = self.collectionView.bounds.size.width - [self sectionInset].right - lastOneFrame.size.width;
            lastOneAttributes.frame = lastOneFrame;
            
            for (NSInteger j = tempCellAttributesArray.count - 2; j >= 0; j--) {
                UICollectionViewLayoutAttributes *currentAttributes = tempCellAttributesArray[j];
                UICollectionViewLayoutAttributes *lastAttributes = tempCellAttributesArray[j + 1];
                if (currentAttributes.frame.origin.y == lastAttributes.frame.origin.y) {
                    CGRect frame = currentAttributes.frame;
                    frame.origin.x = CGRectGetMinX(lastAttributes.frame) - self.fixSpacing - frame.size.width;
                    currentAttributes.frame = frame;
                }
            }
            
            /*
            //先将获取到的cell的attributes按行分组
            NSMutableArray *tempRowsArray = [NSMutableArray array];
            NSMutableArray *tempOneRow = [NSMutableArray array];
            UICollectionViewLayoutAttributes *tempLastAttributes = nil;
            for (UICollectionViewLayoutAttributes *anAttributes in tempCellAttributesArray) {
                //与上一个attributes进行对比，如果同一行则加到后面，否则新建一行
                if (tempLastAttributes) {
                    if (tempLastAttributes.frame.origin.y == anAttributes.frame.origin.y) {
                        [tempOneRow addObject:anAttributes];
                    } else {
                        [tempRowsArray addObject:tempOneRow];
                        tempOneRow = [NSMutableArray array];
                        [tempOneRow addObject:anAttributes];
                    }
                } else {
                    [tempOneRow addObject:anAttributes];
                }
                tempLastAttributes = anAttributes;
            }
            
            for (NSArray *oneRow in tempRowsArray) {
                for (NSInteger i = oneRow.count - 2; i >= 0; i--) {
                    UICollectionViewLayoutAttributes *currentAttributes = oneRow[i];
                    UICollectionViewLayoutAttributes *lastAttributes = oneRow[i + 1];
                    CGRect frame = currentAttributes.frame;
                    frame.origin.x = CGRectGetMinX(lastAttributes.frame) - self.fixSpacing - frame.size.width;
                    currentAttributes.frame = frame;
                }
            }
             */
        } else if (self.cellAlignment == LLFixSapcingLayoutCellAlignmentCenter) {
            
            //先将获取到的cell的attributes按行分组
            NSMutableArray *tempRowsArray = [NSMutableArray array];
            NSMutableArray *tempOneRow = [NSMutableArray array];
            UICollectionViewLayoutAttributes *tempLastAttributes = nil;
            for (UICollectionViewLayoutAttributes *anAttributes in tempCellAttributesArray) {
                //与上一个attributes进行对比，如果同一行则加到后面，否则新建一行
                if (tempLastAttributes) {
                    if (tempLastAttributes.frame.origin.y == anAttributes.frame.origin.y) {
                        [tempOneRow addObject:anAttributes];
                    } else {
                        [tempRowsArray addObject:tempOneRow];
                        tempOneRow = [NSMutableArray array];
                        [tempOneRow addObject:anAttributes];
                    }
                } else {
                    [tempOneRow addObject:anAttributes];
                }
                tempLastAttributes = anAttributes;
            }
            //把最后一行加上
            [tempRowsArray addObject:tempOneRow];
            
            for (NSArray *oneRow in tempRowsArray) {
                
                CGFloat fullWidth = 0;
                for (UICollectionViewLayoutAttributes *anAttributes in oneRow) {
                    fullWidth += anAttributes.frame.size.width;
                }
                fullWidth += (oneRow.count - 1) * self.fixSpacing;
                
                CGFloat margin = self.collectionView.bounds.size.width - fullWidth;
                UICollectionViewLayoutAttributes *firstOneAttributes = [oneRow firstObject];
                CGRect firstFrame = firstOneAttributes.frame;
                firstFrame.origin.x = margin / 2;
                firstOneAttributes.frame = firstFrame;
                
                for (NSInteger i = 1; i < oneRow.count; i++) {
                    UICollectionViewLayoutAttributes *currentAttributes = oneRow[i];
                    UICollectionViewLayoutAttributes *lastAttributes = oneRow[i - 1];
                    CGRect frame = currentAttributes.frame;
                    frame.origin.x =CGRectGetMaxX(lastAttributes.frame) + self.fixSpacing;
                    currentAttributes.frame = frame;
                }
            }
            
        }
        
    }
    
    return attributesArray;
}

@end
