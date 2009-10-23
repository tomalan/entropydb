//
//  XSDatabase.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "sqlite3.h"

@interface XSDatabase : NSObject {
	sqlite3* db;
	NSMutableDictionary* objectIDs;
}

- (id)initWithFile:(NSString*)path;
- (void)storeObject:(id)obj;
- (sqlite3*)database;
- (NSMutableDictionary*)objectIDs;
- (NSArray*)queryWithClass:(Class)cls;

@end
