//
//  VerificationCodeVC.m
//  CardGame
//
//  Created by Ten on 2020/2/5.
//  Copyright © 2020年 Ten. All rights reserved.
//

#import "VerificationCodeVC.h"
#import "Masonry.h"
#import "JCNetworking.h"

static NSInteger h_BG = 200;//背景的高度
static NSInteger w_BG = 300;//滑动的宽度度

static NSInteger h_slider = 25;//滑块的高度
static NSInteger w_Slider = 40;//滑动的宽度

static NSInteger h_Bottom = 30;//底部的高度

static NSInteger h_Big = 116;//大图的高度
static NSInteger w_Big = 260;//大图的宽度

static NSInteger h_Small = 40;//小图的高度
static NSInteger w_Small = 40;//小图的宽度
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface VerificationCodeVC ()

@property(nonatomic,strong)UIView *view_bg;//正中间的背景图
@property(nonatomic,strong)UIView *view_top;//顶部图片 包含刷新、拖动图等
@property(nonatomic,strong)UIImageView *imageV_big;//图片大图
@property(nonatomic,strong)UIImageView *imageV_small;//图片小图
@property(nonatomic,strong)UIButton *btn_refresh;//刷新按钮


@property(nonatomic,strong)UIView *view_bottom;//底部图片 拖动
@property(nonatomic,strong)UIImageView *imageV_slider;//拖动
@property(nonatomic,strong)NSString *y_point;//小图距离大图高
@property(nonatomic,strong)NSString *passport;//小图距离大图高
@property(nonatomic,strong)NSString *h_BigOne;
@property(nonatomic,strong)NSString *w_BigOne;
@property(nonatomic,strong)NSString *h_SmallOne;
@property(nonatomic,strong)NSString *w_SmallOne;
@property(nonatomic,strong)NSString *x_value;//传给后台的值

@end

@implementation VerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self creatUI];
}


-(void)getData{
    NSDictionary *dict = @{@"token":@"W2WAar8QWQPJPxcnBmZQ62zkG940z8HO82PV2zM2"};
    [JCNetworking GET:@"https://www.ws88168.com/api/m/SlideVerify" parameters:dict success:^(id responseObject) {
        
        NSString *bigDataStr = responseObject[@"bg_pic"][@"url"];
        NSString *smallDataStr = responseObject[@"ico_pic"][@"url"];
        self.y_point = [NSString stringWithFormat:@"%@",responseObject[@"y_point"]];
        self.passport = responseObject[@"passport"];
        
        
        NSArray *bigArray = [bigDataStr componentsSeparatedByString:@"base64,"];
        NSString *bigStr = bigArray.lastObject;
        NSData * bigData =[[NSData alloc] initWithBase64EncodedString:bigStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        NSArray *samllArray = [smallDataStr componentsSeparatedByString:@"base64,"];
        NSString *smallStr = samllArray.lastObject;
        NSData * smallData =[[NSData alloc] initWithBase64EncodedString:smallStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.imageV_big.image = [UIImage imageWithData: bigData];
            self.imageV_small.image = [UIImage imageWithData: smallData];
        });
        NSString *strOne = [NSString stringWithFormat:@"%@",responseObject[@"bg_pic"][@"h"]];
        NSString *strTwo = [NSString stringWithFormat:@"%@",responseObject[@"bg_pic"][@"w"]];
        h_Big = strOne.integerValue;
        w_Big = strTwo.integerValue;
        
        NSString *strThree = [NSString stringWithFormat:@"%@",responseObject[@"ico_pic"][@"h"]];
        NSString *strFour = [NSString stringWithFormat:@"%@",responseObject[@"ico_pic"][@"w"]];
        h_Small = strThree.integerValue;
        w_Small = strFour.integerValue;
        [self creatUI];

    } failure:^(NSError *error) {
        //登录失败
    }];
}


-(void)creatUI{
    
    

    //底部背景
    
    [self.view_bg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(w_BG);
        make.height.mas_equalTo(h_BG);
    }];
    
    //顶部图片 包含刷新、拖动图等
    [self.view_top mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view_bg);
        make.height.mas_equalTo(self.view_bg).mas_offset(-h_Bottom);

    }];

    //图片大图

    [self.imageV_big mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view_top);
        make.top.mas_equalTo(self.view_top).mas_offset(20);
        make.height.mas_equalTo(h_Big);
        make.width.mas_equalTo(w_Big);
    }];

    //图片小图

    [self.imageV_small mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV_big).mas_offset(self.y_point.integerValue);
        make.left.mas_equalTo(self.imageV_big);
        make.height.mas_equalTo(h_Small);
        make.width.mas_equalTo(w_Small);
    }];
    
    //刷新按钮
    
    [self.btn_refresh mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV_big.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(self.imageV_big);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    
    [self.view_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view_top.mas_bottom);
        make.width.mas_equalTo(w_Big);
        make.centerX.mas_equalTo(self.view_bg);
        make.bottom.mas_equalTo(self.view_bg);
    }];
    
    //滑动

    
    [self.imageV_slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.mas_equalTo(self.view_bottom);
        make.height.mas_equalTo(h_slider);
        make.width.mas_equalTo(w_Slider);

    }];
    
    
}

/**
 *  实现拖动手势方法
 *
 *  @param panGestureRecognizer 手势本身
 */
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    //获取拖拽手势在self.view 的拖拽姿态
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    //改变panGestureRecognizer.view的中心点 就是self.imageView的中心点
    CGFloat space = 0;
    
    
    panGestureRecognizer.view.center = CGPointMake(panGestureRecognizer.view.center.x + translation.x, panGestureRecognizer.view.center.y);
    
    if (self.imageV_slider.frame.origin.x <= space && translation.x<0){
        self.imageV_slider.frame = CGRectMake(space, self.imageV_slider.frame.origin.y, self.imageV_slider.frame.size.width, self.imageV_slider.frame.size.height);
    }
    
    if (self.imageV_slider.frame.origin.x + w_Slider >= w_Big+space && translation.x>0) {
            self.imageV_slider.frame = CGRectMake(w_Big+space-w_Slider, self.imageV_slider.frame.origin.y, self.imageV_slider.frame.size.width, self.imageV_slider.frame.size.height);
    }
    
    CGFloat x = self.imageV_slider.frame.origin.x/(self.view_bottom.frame.size.width-w_Slider) *(w_Big-w_Small);
    self.imageV_small.frame = CGRectMake(x, self.imageV_small.frame.origin.y, self.imageV_small.frame.size.width, self.imageV_small.frame.size.height);
    
//    CGRect focusFrame = [self.view convertRect:self.imageV_small.frame toView:self.imageV_big];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //停止
        self.x_value = [NSString stringWithFormat:@"%f",x];
        //发送对应请求
    }
    //重置拖拽手势的姿态
    [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
}

-(void)refresh{
    CGFloat space = 0;
    self.imageV_slider.frame = CGRectMake(space, self.imageV_slider.frame.origin.y, self.imageV_slider.frame.size.width, self.imageV_slider.frame.size.height);
    self.x_value = 0;
    [self getData];
}

-(UIView *)view_bg{
    if (!_view_bg) {
        _view_bg = [[UIView alloc]init];
        _view_bg.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_view_bg];
    }
    return _view_bg;
}


-(UIView *)view_top{
    
    if (!_view_top) {
       _view_top = [[UIView alloc]init];
        _view_top.backgroundColor = kRGBColor(237, 231, 218);
        [self.view_bg addSubview:_view_top];
        _view_top.layer.cornerRadius = 10;
    }
    return _view_top;

}


-(UIView *)imageV_big{
    if (!_imageV_big) {
        _imageV_big = [[UIImageView alloc]init];
        _imageV_big.backgroundColor = [UIColor greenColor];
        [self.view_top addSubview:_imageV_big];
    }
    return _imageV_big;
}

-(UIImageView *)imageV_small{
    if (!_imageV_small) {
        _imageV_small = [[UIImageView alloc]init];
        _imageV_small.backgroundColor = [UIColor whiteColor];
        [self.imageV_big addSubview:_imageV_small];
    }
    return _imageV_small;
}

-(UIButton *)btn_refresh{
    if (!_btn_refresh) {
        _btn_refresh = [[UIButton alloc]init];
        [_btn_refresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [_btn_refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchDown];
        [self.view_top addSubview:_btn_refresh];
    }
    return _btn_refresh;
}

-(UIView *)view_bottom{
    if (!_view_bottom) {
        _view_bottom = [[UIView alloc]init];
        _view_bottom.backgroundColor = kRGBColor(228, 228, 212);
        _view_bottom.layer.cornerRadius = 15;
        _view_bottom.layer.masksToBounds = YES;
        _view_bottom.layer.borderWidth = 1;
        _view_bottom.layer.borderColor = kRGBColor(44, 44, 44).CGColor;
        [self.view_bg addSubview:_view_bottom];
    }
    return _view_bottom;
}

-(UIImageView *)imageV_slider{
    if (!_imageV_slider) {
        _imageV_slider = [[UIImageView alloc]init];
        _imageV_slider.image = [UIImage imageNamed:@"slider"];
        [self.view_bottom addSubview:_imageV_slider];
        _imageV_slider.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        [_imageV_slider addGestureRecognizer:pan];
    }
    return _imageV_slider;
}

@end
