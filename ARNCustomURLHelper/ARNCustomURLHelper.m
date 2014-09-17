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

@import MessageUI;

@interface ARNCustomURLHelper () <MFMailComposeViewControllerDelegate>

@property (nonatomic, copy) ARNCustomURLHelperFailureBlock failureBlock;

@end

@implementation ARNCustomURLHelper

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
    [[self class] openCustomURLSchemeWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]] failureBlock:failureBlock];
}

+ (void)sendEMailForSubject:(NSString *)subject
                       body:(NSString *)body
                    address:(NSString *)address
               failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    NSMutableString *mString = [NSMutableString string];
    if (address) {
        [mString appendString:address];
    }
    if (subject) {
        [mString appendFormat:@"?subject=%@", [subject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    } else {
        [mString appendFormat:@"?subject="];
    }
    if (body) {
        [mString appendFormat:@"&body==%@", [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    [[self class] openCustomURLSchemeWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", mString]] failureBlock:failureBlock];
}


- (void)modalEMailForSubject:(NSString *)subject
                        body:(NSString *)body
                     address:(NSString *)address
                       owner:(UIViewController *)owner
                failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        [mailVC setSubject:subject];
        [mailVC setToRecipients:@[address]];
        [mailVC setMessageBody:body isHTML:NO];
        mailVC.mailComposeDelegate = self;
        self.failureBlock = failureBlock;
        [owner presentViewController:mailVC animated:YES completion:nil];
    } else {
        if (failureBlock) {
            failureBlock();
        }
    }
}

- ( void )mailComposeController:(MFMailComposeViewController *)controller
            didFinishWithResult:(MFMailComposeResult)result
                          error:(NSError *)error
{
    if(error) {
        if (self.failureBlock) {
            self.failureBlock();
        }
        
    } else {
        switch( result ) {
            case MFMailComposeResultSent:
                // メールを送信
                break;
            case MFMailComposeResultSaved:
                // メールを保存
                break;
            case MFMailComposeResultCancelled:
                // キャンセル
                break;
            case MFMailComposeResultFailed:
                // 失敗
                if (self.failureBlock) {
                    self.failureBlock();
                }
                break;
            default:
                break;
        }
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

// -----------------------------------------------------------------------------------------------------------------------//
#pragma mark - Line

+ (void)sendLineForText:(NSString *)testString failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    [[self class] openCustomURLSchemeWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"line://msg/text/%@", [[self class] escapeString:testString]]] failureBlock:failureBlock];
}

+ (void)sendLineForImage:(UIImage *)image failureBlock:(ARNCustomURLHelperFailureBlock)failureBlock
{
    [[UIPasteboard generalPasteboard] setData:UIImageJPEGRepresentation(image, 0.8) forPasteboardType:@"public.jpeg"];
    [[self class] openCustomURLSchemeWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"line://msg/image/%@", [UIPasteboard generalPasteboard].name]] failureBlock:failureBlock];
}

@end
