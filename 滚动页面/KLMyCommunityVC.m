//
//  KLMyCommunityVC.m
//  COMELIVE
//
//  Created by 张晓亮 on 2018/12/25.
//  Copyright © 2018 CCMac. All rights reserved.
//

#import "KLMyCommunityVC.h"
#import "KLScrollItemView.h"
#import "defin.h"
#import <Masonry/Masonry.h>
@interface KLMyCommunityVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *scrollContentView;
@property(nonatomic,strong)KLScrollItemView *barView;
@end

@implementation KLMyCommunityVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor;
    [self initSubViews];

    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    [self addSubVC:@[vc,UIViewController.new,UIViewController.new,UIViewController.new]];
    
}

-(void)initSubViews {

    KLScrollItemView *item = [KLScrollItemView new];
    self.barView = item;
    KLScrollItemViewConfig *config = [KLScrollItemViewConfig new];
    config.canScroll = NO;
    config.displayBottomLine = YES;
    config.leftMargin = 0;
    config.rightMargin = 0;
    config.autoSuitItemsPosition = NO;
    config.autolayoutItemSize = NO;
    config.itemSize = CGSizeMake(ScreenWidth/4, 45.0);
    config.titleFont = Font(14);
    config.itemNormalColor = Color999;
    config.itemSelectedColor = RGB_X(0xFFFFFF);
    config.indicatorIDViewColor = RGB_X(0xFF2481);
    config.bottomLineViewColor = Color333;

    item.config = config;

    __weak typeof(self)weak_self = self;
    [item setTitles:@[@"创客群",@"粉丝群",@"课程群",@"群管理"] selectindex:0 seleledEvent:^(NSInteger selecedIndex) {
        [weak_self.scrollView setContentOffset:CGPointMake(selecedIndex * ScreenWidth, 0) animated:YES] ;

    }];

    [self.view addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(@(88));
        make.height.equalTo(@(45));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
    }];

    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.directionalLockEnabled = YES;
    
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(item.mas_bottom);
        make.bottom.equalTo(@(0));
    }];

    self.scrollContentView = [UIView new];
    [self.scrollView addSubview:self.scrollContentView];
    [self.scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.scrollView.mas_left);
        make.right.equalTo(self.scrollView.mas_right);
        make.top.equalTo(self.scrollView.mas_top);
        make.bottom.equalTo(self.scrollView.mas_bottom);
        make.width.equalTo(@(0));
        make.height.equalTo(@(ScreenHeight - 88 - 45));
    }];

    
}



- (void)addSubVC:(NSArray <UIViewController*>*)vcs{

    [self.scrollContentView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.width.equalTo(@(ScreenWidth*vcs.count));
    }];

    __weak typeof(self)weak_self = self;
    [vcs enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weak_self addChildViewController:obj];
        [weak_self.scrollContentView addSubview:obj.view];
        if (idx == 0) {

            [obj.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                make.left.equalTo(@(0));
                make.width.equalTo(@(ScreenWidth));
                make.bottom.equalTo(self.scrollContentView.mas_bottom);

            }];
        } else {

            UIViewController *lastVC = vcs[idx - 1];
            [obj.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                make.left.equalTo(lastVC.view.mas_right);
                make.width.equalTo(@(ScreenWidth));
                make.bottom.equalTo(self.scrollContentView.mas_bottom);

            }];
        }


    }];


}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger index = self.scrollView.contentOffset.x/ScreenWidth + 0.5;

    if (index != self.barView.selectIndex) {

        self.barView.selectIndex = index;
    }

}
@end
