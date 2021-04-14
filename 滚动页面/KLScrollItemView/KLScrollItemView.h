//
//  KLScrollItemView.h
//  COMELIVE
//
//  Created by 张晓亮 on 2018/12/25.
//  Copyright © 2018 CCMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN
@interface KLScrollItemViewConfig : NSObject

//第一个item距离左边的距离
@property(nonatomic,assign) CGFloat leftMargin;
//最后一个item距离右边边的距离
@property(nonatomic,assign) CGFloat rightMargin;
//item标题字体
@property(nonatomic,strong) UIFont *itemNomalTitleFont;
@property(nonatomic,assign) UIFont *itemSelectedFont;
//item标题默认颜色
@property(nonatomic,strong) UIColor *itemNormalColor;
//item标题选中时颜色
@property(nonatomic,strong) UIColor *itemSelectedColor;

//item之间的间距
@property(nonatomic,assign) CGFloat itemSpaceSize;

@end


@interface KLScrollItemView : UIView
@property(nonatomic,strong) KLScrollItemViewConfig *config;
@property(nonatomic,assign) NSInteger selectIndex;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIView *indicatorIDView;
@property(nonatomic,strong) UIView *bottomLine;


//button自动计算大小的
-(void)setautolayoutItemSizeTitle :(NSMutableArray *)titles
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView *indicatorIDView, NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn))event;

//设置一个button到合适且可见的位置
- (void)autoSuitItemsPositionWithSelectBtn:(UIButton *)btn;

//自动移动button到合适且可见的位置
-(void)setSuitSelectedItemPositionWithTitles :(NSMutableArray *)titles
        itemSize:(CGSize)ItemSize
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView *indicatorIDView, NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn))event;

-(void)setTitles:(NSMutableArray *)titles
        itemSize:(CGSize (^)(NSString *Btntitle))itemSize
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView *indicatorIDView, NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn ))event;
//最底层的方法
-(void)setTitles:(NSMutableArray *)titles
        createButtonCallBack:(void (^)(UIButton *btn,NSInteger index))ButtonCallBack
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView * indicatorIDView,NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn))event;


@end

NS_ASSUME_NONNULL_END
