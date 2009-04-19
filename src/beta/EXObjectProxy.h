//
//  EXProxy.h
//  CRo
//
//  Created by Petr Homola on 9.09.08.
//  Copyright 2008 Univerzita Karlova. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LEASETIME 600

@interface EXObjectProxy : NSObject {
	Class cls;
	NSValue* key;
	NSTimer* leaseTimer;
	unsigned port;
	NSString* host;
}

+ (id)proxyForClass:(Class)_cls port:(unsigned)_port host:(NSString*)_host;
- (id)initWithClass:(Class)_cls port:(unsigned)_port host:(NSString*)_host;

@end
