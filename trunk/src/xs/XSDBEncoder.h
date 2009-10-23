//
//  XSDBEncoder.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XSEncoder.h"
#import "sqlite3.h"

@class XSDatabase;

@interface XSDBEncoder : XSEncoder {
	XSDatabase* database;
	BOOL topLevel;
	BOOL committedOrRolledback;
	NSMutableString* createTableSQLCommand;
	NSMutableString* createIndexSQLCommand;
	NSMutableString* insertSQLCommand;
	NSMutableString* insertSQLTail;
	NSMutableString* updateSQLCommand;
	NSMutableArray* SQLValues;
	NSString* propertyName;
	NSString* objectKey;
}

- (void)setDatabase:(XSDatabase*)_db topLevel:(BOOL)_topLevel;
- (BOOL)executeSQL:(NSString*)SQLCommand;
- (BOOL)executeSQL:(NSString*)SQLCommand variables:(NSArray*)variables;
+ (NSString*)uniqueID;
- (void)rollbackTransaction;

@end
