//
//  VerificationCodeView.h
//  VerificationCode
//
//  Created by Ten on 2020/2/5.
//  Copyright © 2020年 KNone. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)(NSString *x_value,NSString *passport);
NS_ASSUME_NONNULL_BEGIN

@interface VerificationCodeView : UIView
@property(nonatomic,copy)SuccessBlock successBlock;

@end

NS_ASSUME_NONNULL_END
