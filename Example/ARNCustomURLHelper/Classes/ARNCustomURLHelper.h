//
//  ARNCustomURLHelper.h
//  ARNCustomURLHelper
//
//  Created by Airin on 2014/05/14.
//  Copyright (c) 2014 Airin. All rights reserved.
//

typedef void (^ARNCustomURLHelperFailureBlock)();

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ARNCustomURLHelper : NSObject

// Basic
+ (void)callPhoneForNumber:(NSString *)phoneNumber failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock;

+ (void)sendEMailForSubject:(NSString *)subject
                       body:(NSString *)body
                    address:(NSString *)address
               failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock;

- (void)modalEMailForSubject:(NSString *)subject
                        body:(NSString *)body
                     address:(NSString *)address
                       owner:(UIViewController *)owner
                failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock;

- (void)setModaiEmailNavigationBarTintColor:(UIColor *)tintColor;
- (void)setModalMailNavigationBarTitleTextAttributes:(NSDictionary *)attributes;

// Line
+ (void)sendLineForText:(NSString *)testString failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock;

+ (void)sendLineForImage:(UIImage *)image failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock;

@end
