//
//  UIDevice+XCDevice.m
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "UIDevice+XCDevice.h"
#include <ifaddrs.h>
#include <net/if.h>
#include <arpa/inet.h>

#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation UIDevice (XCDevice)

+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[self currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

+ (NSString *)localIPAddress {
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    
    if (getifaddrs(&addrs) == 0) {
        const struct ifaddrs *cursor = addrs;
        
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    
    return localIP;
}

+ (BOOL)callPhoneSupported {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

+ (BOOL)connectedToNetwork {
    SCNetworkReachabilityFlags flags;
    
    if (![self checkConnection:&flags]) return NO;
    
    BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkReachabilityFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL)connectedToWiFi {
    SCNetworkReachabilityFlags flags;
    
    if (![self checkConnection:&flags]) return NO;
    
    BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkReachabilityFlagsConnectionRequired;
    BOOL cellConnected = flags & kSCNetworkReachabilityFlagsTransientConnection;
    
    return (isReachable && !needsConnection && !cellConnected) ? YES : NO;
}

#pragma mark --Private API
+ (BOOL)checkConnection:(SCNetworkReachabilityFlags *)flags {
    struct sockaddr_in zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, flags) ? YES : NO;
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) return NO;
    
    return YES;
}

@end
