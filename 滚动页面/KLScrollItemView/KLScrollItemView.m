//
//  KLScrollItemView.m
//  COMELIVE
//
//  Created by 张晓亮 on 2018/12/25.
//  Copyright © 2018 CCMac. All rights reserved.
//

#import "KLScrollItemView.h"
//#import <Masonry/Masonry.h>
#import "Masonry.h"

@implementation KLScrollItemViewConfig

@end





@interface KLScrollItemView ()

@property(nonatomic,strong) NSMutableArray <UIButton *>*btnList;
@property(nonatomic,copy) void (^selectEventNew)(NSInteger selectedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn);
@property(nonatomic,copy) CGSize (^indicatorIDViewChangePositCallBack)(UIView *indicatorIDView, NSInteger indexPositionBtn);
@property(nonatomic,strong)UIView *scrollViewHeightView;
@end

@implementation KLScrollItemView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        self.indicatorIDView.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollViewHeightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}

#pragma mark 懒加载
-(UIView *)scrollViewHeightView {
    
    if (!_scrollViewHeightView) {
        _scrollViewHeightView = [UIView new];
        _scrollViewHeightView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:_scrollViewHeightView];
//        __weak typeof(self) weakSelf = self;
        [_scrollViewHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.scrollView.mas_top);
            make.bottom.equalTo(self.scrollView.mas_bottom);
            make.left.equalTo(self.scrollView.mas_left);
            make.width.equalTo(@(0.5));
            make.height.equalTo(self.mas_height).offset(-0.5);
        }];
    }
    
    return _scrollViewHeightView;
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



#pragma function
-(void)setautolayoutItemSizeTitle :(NSMutableArray *)titles
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView *indicatorIDView, NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn))event {

	__weak typeof(self) weakSelf = self;
	[self setTitles:titles itemSize:^CGSize (NSString *Btntitle) {

	         CGSize btnSize =  [Btntitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: weakSelf.config.itemNomalTitleFont} context:nil].size;
	         return btnSize;
	 } indicatorIDViewChangePositCallBack:indicatorIDViewChangePositCallBack selectindex:index seleledEvent:event];
}

-(void)setSuitSelectedItemPositionWithTitles :(NSMutableArray *)titles
        itemSize:(CGSize)ItemSize
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView *indicatorIDView, NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn))event {


	__weak typeof(self) weakSelf = self;
	[self setTitles:titles itemSize:^CGSize (NSString *Btntitle) {

	         return ItemSize;
	 } indicatorIDViewChangePositCallBack:indicatorIDViewChangePositCallBack selectindex:index seleledEvent:^(NSInteger selecedIndex1, UIButton *oldSelectedBtn1, UIButton *selectedBtn1) {

	         event(selecedIndex1,oldSelectedBtn1,selectedBtn1);
	         [weakSelf autoSuitItemsPositionWithSelectBtn:selectedBtn1];
	 }];

}





-(void)setTitles:(NSMutableArray *)titles
        itemSize:(CGSize (^)(NSString *Btntitle))itemSize
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView *indicatorIDView, NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn ))event
{

	__weak typeof(self) weakSelf = self;
	[self setTitles:titles createButtonCallBack:^(UIButton * _Nonnull btn, NSInteger index1) {

	         [btn setTitleColor:weakSelf.config.itemNormalColor forState:UIControlStateNormal];
	         [btn setTitleColor:weakSelf.config.itemSelectedColor forState:UIControlStateSelected];
	         if (index1 != index ) {
			 btn.titleLabel.font = weakSelf.config.itemNomalTitleFont;
			 btn.selected = NO;
		 } else {

			 btn.selected = YES;
			 btn.titleLabel.font = weakSelf.config.itemSelectedFont;
		 }

	         CGSize btnSize = itemSize(titles[index1]);
	         if (index1 == 0) {
			 [btn mas_makeConstraints:^(MASConstraintMaker *make) {

			          make.left.equalTo(@(weakSelf.config.leftMargin));
			          make.width.equalTo(@(btnSize.width));

			          make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
			          make.height.equalTo(@(btnSize.height));
			  }];
		 } else {

			 [btn mas_makeConstraints:^(MASConstraintMaker *make) {
			          make.left.equalTo(weakSelf.btnList[index1 - 1].mas_right).offset(weakSelf.config.itemSpaceSize);
			          make.width.equalTo(@(btnSize.width));
			          make.height.equalTo(@(btnSize.height));
			          make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
			  }];
		 }

	 } indicatorIDViewChangePositCallBack:indicatorIDViewChangePositCallBack selectindex:index seleledEvent:^(NSInteger selecedIndex, UIButton * _Nonnull oldSelectedBtn1, UIButton * _Nonnull selectedBtn1) {

	         [UIView animateWithDuration:0.2 animations:^{

	                  oldSelectedBtn1.titleLabel.font = weakSelf.config.itemNomalTitleFont;
	                  selectedBtn1.titleLabel.font = weakSelf.config.itemSelectedFont;
		  }];

	         event(selecedIndex,oldSelectedBtn1,selectedBtn1);
	 }];


	[self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {

	         make.height.equalTo(@(0.5));
	         make.bottom.equalTo(weakSelf.mas_bottom);
	         make.left.equalTo(@(0));
	         make.right.equalTo(@(0));
	 }];

}


-(void)btnitemClick:(UIButton *)btn
{

	__weak typeof(self) weakSelf = self;
	UIButton *oldSelectedBtn = self.btnList[_selectIndex];
	oldSelectedBtn.selected = NO;

	btn.selected = YES;
	_selectIndex = [self.btnList indexOfObject:btn];
	if (self.selectEventNew) {
		self.selectEventNew(_selectIndex, oldSelectedBtn, btn);
	}

	CGSize size = CGSizeZero;
	if(self.indicatorIDViewChangePositCallBack) {
		size = self.indicatorIDViewChangePositCallBack(self.indicatorIDView,_selectIndex);
	}

	[self.indicatorIDView mas_remakeConstraints:^(MASConstraintMaker *make) {

	         make.centerX.equalTo(btn.mas_centerX);
	         make.height.equalTo(@(size.height));
	         make.width.equalTo(@(size.width));
	         make.bottom.equalTo(weakSelf.scrollView.mas_bottom);
	 }];
    
    [self.scrollViewHeightView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.scrollView.mas_top);
        make.bottom.equalTo(self.scrollView.mas_bottom);
        make.left.equalTo(self.scrollView.mas_left);
        make.width.equalTo(@(0.5));
        make.height.equalTo(self.mas_height).offset(-size.height);
     }];

	[UIView animateWithDuration:0.2 animations:^{

	         [weakSelf.scrollView layoutIfNeeded];
	 }];


}

-(void)setSelectIndex:(NSInteger)selectIndex
{
	if (selectIndex > self.btnList.count - 1) {

		return;
	}
	if (_selectIndex != selectIndex) {

		_selectIndex = selectIndex;

		__weak typeof(self) weakSelf = self;

		UIButton *oldSelectedBtn = self.btnList[_selectIndex];
		oldSelectedBtn.selected = NO;

		UIButton *btn = self.btnList[selectIndex];

		btn.selected = YES;

		CGSize size = CGSizeZero;
		if(self.indicatorIDViewChangePositCallBack) {
			size = self.indicatorIDViewChangePositCallBack(self.indicatorIDView,selectIndex);

		}
		[weakSelf.indicatorIDView mas_remakeConstraints:^(MASConstraintMaker *make) {

		         make.centerX.equalTo(btn.mas_centerX);
		         make.height.equalTo(@(size.height));
		         make.width.equalTo(@(size.width));
		         make.bottom.equalTo(weakSelf.scrollView.mas_bottom);
		 }];
        
        [self.scrollViewHeightView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.scrollView.mas_top);
            make.bottom.equalTo(self.scrollView.mas_bottom);
            make.left.equalTo(self.scrollView.mas_left);
            make.width.equalTo(@(0.5));
            make.height.equalTo(self.mas_height).offset(-size.height);
         }];
		[UIView animateWithDuration:0.2 animations:^{

		         [weakSelf.scrollView layoutIfNeeded];

		 }];
	}
}

/** 自动匹配分类栏目按钮的contentOffset */
- (void)autoSuitItemsPositionWithSelectBtn:(UIButton *)btn
{

	CGFloat insetLeft = 0;
	CGFloat insetRight = 0;
	__weak typeof(self) weakSelf = self;
	[UIView animateWithDuration:0.3 animations:^{
	         if(weakSelf.scrollView.contentSize.width > weakSelf.scrollView.frame.size.width) {
			 CGFloat desiredX = btn.center.x - (weakSelf.scrollView.bounds.size.width/2);
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




-(void)setTitles:(NSMutableArray *)titles
        createButtonCallBack:(void (^)(UIButton *btn,NSInteger index))ButtonCallBack
        indicatorIDViewChangePositCallBack:(CGSize (^)(UIView * indicatorIDView,NSInteger indexPositionBtn))indicatorIDViewChangePositCallBack
        selectindex:(NSInteger) index
        seleledEvent:(void (^)(NSInteger selecedIndex,UIButton *oldSelectedBtn,UIButton *selectedBtn))event {


	__weak typeof(_indicatorIDView) weakIndicatorIDView = _indicatorIDView;

	self.indicatorIDViewChangePositCallBack = indicatorIDViewChangePositCallBack;

	__weak typeof(self) weakSelf = self;
	[self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
	         if (obj != weakIndicatorIDView) {
                 if (obj != weakSelf.scrollViewHeightView) {
                     
                     [obj removeFromSuperview];
                 }
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
		[btn setTitle:title forState:UIControlStateSelected];
		[btn setTitle:title forState:UIControlStateHighlighted];
		[self.scrollView addSubview:btn];
		[self.btnList addObject:btn];

		if (ButtonCallBack) {
			ButtonCallBack(btn,[titles indexOfObject:title]);
		}

		if ([titles indexOfObject:title] == index) {

			CGSize size = CGSizeZero;
			if (indicatorIDViewChangePositCallBack) {
				size = self.indicatorIDViewChangePositCallBack(self.indicatorIDView,index);
			}
			[self.indicatorIDView mas_remakeConstraints:^(MASConstraintMaker *make) {

			         make.centerX.equalTo(btn.mas_centerX);
			         make.height.equalTo(@(size.height));
			         make.width.equalTo(@(size.width));
			         make.bottom.equalTo(weakSelf.scrollView.mas_bottom);
			 }];
            
            [self.scrollViewHeightView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.top.equalTo(self.scrollView.mas_top);
                make.bottom.equalTo(self.scrollView.mas_bottom);
                make.left.equalTo(self.scrollView.mas_left);
                make.width.equalTo(@(0.5));
                make.height.equalTo(self.mas_height).offset(-size.height);
             }];

		}

		lastbtn = btn;
	}
	self.selectEventNew = event;

}
@end
