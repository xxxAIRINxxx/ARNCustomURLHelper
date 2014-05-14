//
//  ARNCustomURLHelper.m
//  ARNCustomURLHelper
//
//  Created by Airin on 2014/05/14.
//  Copyright (c) 2014 Airin. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "ARNCustomURLHelper.h"

@implementation ARNCustomURLHelper

+ (NSURL *)urlWithString:(NSString *)aString
{
    if (!aString) { nil; }
    
    return [NSURL URLWithString:[[self class] escapeString:aString]];
}

+ (void)openCustomURLSchemeWithURL:(NSURL *)aURL failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    if (![[UIApplication sharedApplication] canOpenURL:aURL]) {
        if (failureBlock) {
            failureBlock();
        }
    } else {
        [[UIApplication sharedApplication] openURL:aURL];
    }
}

+ (NSString *)escapeString:(NSString *)aString
{
    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                  (CFStringRef)aString,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8);
}

// -----------------------------------------------------------------------------------------------------------------------//
#pragma mark - Basic

+ (void)callPhoneForNumber:(NSString *)phoneNumber failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    [[self class] openCustomURLSchemeWithURL:[[self class] urlWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]] failureBlock:failureBlock];
}

+ (void)sendEMailForSubject:(NSString *)subject body:(NSString *)body address:(NSString *)address failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    NSMutableString *mString = [NSMutableString string];
    if (address) {
        [mString appendString:address];
    }
    if (subject) {
        [mString appendFormat:@"?subject=%@", subject];
    } else {
        [mString appendFormat:@"?subject="];
    }
    if (body) {
        [mString appendFormat:@"&body==%@", body];
    }
    [[self class] openCustomURLSchemeWithURL:[[self class] urlWithString:[NSString stringWithFormat:@"mailto:%@", mString]] failureBlock:failureBlock];
}

// -----------------------------------------------------------------------------------------------------------------------//
#pragma mark - Line

+ (void)sendLineForText:(NSString *)testString failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    [[self class] openCustomURLSchemeWithURL:[[self class] urlWithString:[NSString stringWithFormat:@"line://msg/text/%@", testString]] failureBlock:failureBlock];
}

+ (void)sendLineForImage:(UIImage *)image failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    [[UIPasteboard generalPasteboard] setData:UIImageJPEGRepresentation(image, 0.8) forPasteboardType:@"public.jpeg"];
    [[self class] openCustomURLSchemeWithURL:[[self class] urlWithString:[NSString stringWithFormat:@"line://msg/image/%@", [UIPasteboard generalPasteboard].name]] failureBlock:failureBlock];
}


@end
