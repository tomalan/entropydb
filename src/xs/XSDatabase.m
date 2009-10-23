//
//  XSDatabase.m
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XSDatabase.h"
#import "XSDecomposer.h"
#import "XSDBEncoder.h"
#import "XSComposer.h"

@implementation XSDatabase

- (id)initWithFile:(NSString*)path {
	if (self = [super init]) {
		int rc = sqlite3_open([path UTF8String], &db);
		if (rc) [NSException raise: @"Can't open database" format: @"%s", sqlite3_errmsg(db)];
		objectIDs = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (NSArray*)queryWithClass:(Class)cls {
	XSComposer* composer = [[[XSComposer alloc] init] autorelease];
	//NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
	//							composer, kXSComposerAttribute, nil];
	
	return nil;
}

- (void)storeObject:(id)obj {
	XSDecomposer* decomposer = [[[XSDecomposer alloc] init] autorelease];
	NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								decomposer, kXSDecomposerAttribute, nil];
	XSDBEncoder* encoder = [[[XSDBEncoder alloc] initWithEncodingAttributes: attributes] autorelease];
	[encoder setDatabase: self topLevel: YES];
	@synchronized (self) { // we should do this for SQLITE3
		[encoder startEncoding]; // this begins a new transaction
		@try {
			[decomposer decomposeObject: obj encoder: encoder];
			[encoder finishEncoding]; // this commits the transaction
		} @catch (NSException* exception) {
			[encoder rollbackTransaction];
		}
	}
}

- (NSMutableDictionary*)objectIDs {
	return objectIDs;
}

- (sqlite3*)database {
	return db;
}

- (void)dealloc {
	[objectIDs release];
	sqlite3_close(db);
	[super dealloc];
}

@end
