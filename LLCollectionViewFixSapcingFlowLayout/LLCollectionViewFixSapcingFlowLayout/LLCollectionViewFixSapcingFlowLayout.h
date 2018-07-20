//
//  LLCollectionViewFixSapcingFlowLayout.h
//  LLCollectionViewEqualSpacingFlowLayout
//
//  Created by Totin on 2018/7/6.
//  Copyright © 2018年 Totin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LLFixSapcingLayoutCellAlignment) {
    LLFixSapcingLayoutCellAlignmentFlow = 0,
    LLFixSapcingLayoutCellAlignmentLeft,
    LLFixSapcingLayoutCellAlignmentRight,
    LLFixSapcingLayoutCellAlignmentCenter
};

@interface LLCollectionViewFixSapcingFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) IBInspectable LLFixSapcingLayoutCellAlignment cellAlignment;

@property (nonatomic) IBInspectable CGFloat fixSpacing;

@end
