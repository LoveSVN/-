//
//  KLScrollItemView.m
//  COMELIVE
//
//  Created by 张晓亮 on 2018/12/25.
//  Copyright © 2018 CCMac. All rights reserved.
//

#import "KLScrollItemView.h"
#import <Masonry/Masonry.h>

@implementation KLScrollItemViewConfig

@end





@interface KLScrollItemView ()
@property(nonatomic,copy)void(^selectEvent)(NSInteger selectedIndex);

@property(nonatomic,strong)NSMutableArray <UIButton *>*btnList;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *indicatorIDView;
@property(nonatomic,strong)UIView *bottomLine;
@end

@implementation KLScrollItemView

-(void)setTitles:(NSMutableArray *)titles selectindex:(NSInteger) index seleledEvent:(void(^)(NSInteger selecedIndex))event
{
    __weak typeof(_indicatorIDView)weakIndicatorIDView = _indicatorIDView;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {


        if (obj != weakIndicatorIDView) {

            [obj removeFromSuperview];

        }


    }];

    [self.btnList removeAllObjects];

    _selectIndex = index;
    UIButton *lastbtn = nil;


    self.hidden = titles.count > 0?NO:YES;

    for (NSString *title  in titles) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnitemClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.titleFont;

        [self.scrollView addSubview:btn];

        CGSize btnSize = CGSizeZero;
        if (self.config.autolayoutItemSize) {

        btnSize =  [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.config.titleFont} context:nil].size;


        } else {

            btnSize = self.config.itemSize;
        }

        if (lastbtn) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastbtn.mas_right).offset(self.config.itemSpaceSize);
                make.width.equalTo(@(btnSize.width));
                make.top.equalTo(self.scrollView.mas_top);
                make.bottom.equalTo(self.scrollView.mas_bottom).offset(-1);
            }];
        } else {

            [btn mas_makeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(@(self.config.leftMargin));
                make.width.equalTo(@(btnSize.width));
                make.top.equalTo(self.scrollView.mas_top);
                make.bottom.equalTo(self.scrollView.mas_bottom);
                make.height.equalTo(@(btnSize.height));
            }];

        }

        if ([titles indexOfObject:title] == index) {
            btn.selected = YES;
            [self.indicatorIDView mas_makeConstraints:^(MASConstraintMaker *make) {

                make.centerX.equalTo(btn.mas_centerX);
                make.height.equalTo(@(1));
                make.width.equalTo(@(20));
                make.bottom.equalTo(self.scrollView.mas_bottom);
            }];

        }else
        {
            btn.selected = NO;
        }

        lastbtn = btn;

        [self.btnList addObject:btn];

    }


        self.selectEvent = event;

        self.bottomLine.hidden = !self.config.displayBottomLine;
        self.bottomLine.backgroundColor = self.config.bottomLineViewColor;
        self.indicatorIDView.backgroundColor = self.config.indicatorIDViewColor;
        self.scrollView.scrollEnabled = self.config.canScroll;
    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.height.equalTo(@(0.5));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
}


-(void)btnitemClick:(UIButton *)btn
{

    [self.btnList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        obj.selected = NO;

    }];

    btn.selected = YES;

    [self.indicatorIDView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(btn.mas_centerX);
        make.height.equalTo(@(1));
        make.width.equalTo(@(20));
        make.bottom.equalTo(self.scrollView.mas_bottom);
    }];

    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{

        [weakSelf.scrollView layoutIfNeeded];
    }];
    
    if (self.config.autoSuitItemsPosition) {

        [self autoSuitItemsPositionWithSelectBtn:btn];
    }


    if (self.selectEvent) {

        self.selectEvent([self.btnList indexOfObject:btn]);

    }


}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex > self.btnList.count - 1) {

        return ;
    }
    if (_selectIndex != selectIndex) {

        _selectIndex = selectIndex;

        [self.btnList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = NO;


        }];

        UIButton *btn = self.btnList[selectIndex];

        btn.selected = YES;

        __weak typeof(self)weakSelf = self;

        [weakSelf.indicatorIDView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.centerX.equalTo(btn.mas_centerX);
            make.height.equalTo(@(1));
            make.width.equalTo(@(20));
            make.bottom.equalTo(self.scrollView.mas_bottom);
        }];
        [UIView animateWithDuration:0.2 animations:^{

            [weakSelf.scrollView layoutIfNeeded];

        }];

        if (self.config.autoSuitItemsPosition) {

            [self autoSuitItemsPositionWithSelectBtn:btn];
        }



    }
}

/** 自动匹配分类栏目按钮的contentOffset */
- (void)autoSuitItemsPositionWithSelectBtn:(UIButton *)btn
{

    CGFloat insetLeft = 0;
    CGFloat insetRight = 0;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        if(weakSelf.scrollView.contentSize.width > weakSelf.scrollView.frame.size.width) {
            CGFloat desiredX = btn.center.x - (weakSelf.scrollView.bounds.size.width/2) ;
            if(desiredX < 0.0) desiredX = 0.0;
            if (desiredX > (weakSelf.scrollView.contentSize.width - weakSelf.scrollView.bounds.size.width)) {
                desiredX = (weakSelf.scrollView.contentSize.width - weakSelf.scrollView.bounds.size.width) + insetRight +  insetLeft;
            }
            if (!(weakSelf.scrollView.bounds.size.width > weakSelf.scrollView.contentSize.width)) {
                [weakSelf.scrollView setContentOffset:CGPointMake(desiredX, 0) animated:YES];
            }
        }
    }];
}


-(NSMutableArray *)btnList
{
    if (!_btnList) {

        _btnList = [NSMutableArray array];

    }

    return _btnList;
}


-(UIView *)indicatorIDView
{
    if (!_indicatorIDView) {
        _indicatorIDView = [[UIView alloc] init];
        [self.scrollView addSubview:_indicatorIDView];
    }

    return _indicatorIDView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(-0.5));
        }];
    }

    return _scrollView;
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.height.equalTo(@(.5));
            make.bottom.equalTo(@(0));
        }];
    }
    return _bottomLine;
}
@end
