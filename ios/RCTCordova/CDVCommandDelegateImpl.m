//
//  CDVCommandDelegateImpl.m
//  CDVCommandDelegateImpl
//
//  Created by fangyunjiang on 15/11/17.
//  Copyright (c) 2015年 remobile. All rights reserved.
//

#import "CDVCommandDelegateImpl.h"

@implementation CDVCommandDelegateImpl
- (void)sendPluginResult:(CDVPluginResult*)result callbackId:(CDVInvokedUrlCommand*)callbackId {
    RCTResponseSenderBlock callback = result.status==CDVCommandStatus_OK ? callbackId.success : callbackId.error;
    if (callback != nil) {
        callback(@[result.message?:@""]);
    }
}

- (void)runInBackground:(void (^)())block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}


@end
