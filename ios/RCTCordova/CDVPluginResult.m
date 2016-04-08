/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVPluginResult.h"
#import "NSData+Base64.h"

@interface CDVPluginResult ()

- (CDVPluginResult*)initWithStatus:(CDVCommandStatus)statusOrdinal message:(id)theMessage;

@end

@implementation CDVPluginResult
@synthesize status, message, associatedObject;

static NSArray* org_apache_cordova_CommandStatusMsgs;

id messageFromArrayBuffer(NSData* data)
{
    return @{
             @"CDVType" : @"ArrayBuffer",
             @"data" :[data cdv_base64EncodedString]
             };
}

+ (void)initialize
{
    org_apache_cordova_CommandStatusMsgs = [[NSArray alloc] initWithObjects:@"No result",
                                            @"OK",
                                            @"Class not found",
                                            @"Illegal access",
                                            @"Instantiation error",
                                            @"Malformed url",
                                            @"IO error",
                                            @"Invalid action",
                                            @"JSON error",
                                            @"Error",
                                            nil];
}

- (CDVPluginResult*)init
{
    return [self initWithStatus:CDVCommandStatus_NO_RESULT message:nil];
}

- (CDVPluginResult*)initWithStatus:(CDVCommandStatus)statusOrdinal message:(id)theMessage
{
    self = [super init];
    if (self) {
        status = statusOrdinal;
        message = theMessage;
    }
    return self;
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal
{
    return [[self alloc] initWithStatus:statusOrdinal message:nil];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsString:(NSString*)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:theMessage];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsArray:(NSArray*)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:theMessage];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsInt:(int)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:[NSNumber numberWithInt:theMessage]];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsDouble:(double)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:[NSNumber numberWithDouble:theMessage]];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsBool:(BOOL)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:[NSNumber numberWithBool:theMessage]];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsDictionary:(NSDictionary*)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:theMessage];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageAsArrayBuffer:(NSData*)theMessage
{
    return [[self alloc] initWithStatus:statusOrdinal message:messageFromArrayBuffer(theMessage)];
}

+ (CDVPluginResult*)resultWithStatus:(CDVCommandStatus)statusOrdinal messageToErrorObject:(int)errorCode
{
    NSDictionary* errDict = @{@"code" :[NSNumber numberWithInt:errorCode]};
    
    return [[self alloc] initWithStatus:statusOrdinal message:errDict];
}

@end
