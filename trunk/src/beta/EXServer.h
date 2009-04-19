//
//  EXServer.h
//  CRo
//
//  Created by Petr Homola on 9.09.08.
//  Copyright 2008 Univerzita Karlova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXServer : NSObject {
	NSMutableDictionary* objects;
	NSMutableDictionary* expirationDates;
	NSTimer* leaseTimer;
}

+ (id)server;
- (void)runWithPort:(NSNumber*)port;
- (void)runInThreadWithPort:(unsigned)port;

@end
