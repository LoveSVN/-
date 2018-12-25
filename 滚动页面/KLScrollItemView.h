//
//  KLScrollItemView.h
//  COMELIVE
//
//  Created by 张晓亮 on 2018/12/25.
//  Copyright © 2018 CCMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface KLScrollItemViewConfig : NSObject
//是否显示底部分割线
@property(nonatomic,assign)BOOL displayBottomLine;
//是否能滑动
@property(nonatomic,assign)BOOL canScroll;
//是否根据文字多少自适应itme大小
@property(nonatomic,assign)BOOL autolayoutItemSize;
//是否选中item Item自动滚到可见y区域
@property(nonatomic,assign)BOOL autoSuitItemsPosition;

//底部小横杠的颜色
@property(nonatomic,strong)UIColor *indicatorIDViewColor;
//底部分割线的颜色
@property(nonatomic,strong)UIColor *bottomLineViewColor;
//第一个item距离左边的距离
@property(nonatomic,assign)CGFloat leftMargin;
//最后一个item距离右边边的距离
@property(nonatomic,assign)CGFloat rightMargin;
//item标题字体
@property(nonatomic,strong)UIFont *titleFont;
//item标题默认颜色
@property(nonatomic,strong)UIColor *itemNormalColor;
//item标题选中时颜色
@property(nonatomic,strong)UIColor *itemSelectedColor;

//item大小。如果autolayoutItemSize为YES，这个属性将不使用
@property(nonatomic,assign)CGSize itemSize;
//item之间的间距
@property(nonatomic,assign)CGFloat itemSpaceSize;

@end


@interface KLScrollItemView : UIView
@property(nonatomic,strong)KLScrollItemViewConfig *config;
@property(nonatomic,assign)NSInteger selectIndex;
-(void)setTitles:(NSMutableArray *)titles selectindex:(NSInteger) index seleledEvent:(void(^)(NSInteger selecedIndex))event;
@end

NS_ASSUME_NONNULL_END
