//
//  XSDBEncoder.m
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XSDBEncoder.h"
#import "XSDatabase.h"

@implementation XSDBEncoder

- (void)setDatabase:(XSDatabase*)_db topLevel:(BOOL)_topLevel {
	database = _db;
	topLevel = _topLevel;
}

- (void)startEncoding {
	if (topLevel == YES) {
		[self executeSQL: @"BEGIN TRANSACTION"];
	}
}

- (void)finishEncoding {
	if (topLevel == YES) {
		if (committedOrRolledback == NO) {
			committedOrRolledback = YES;
			[self executeSQL: @"COMMIT"];
		} else { NSLog(@"COMMIT: already committed or rolled back!"); exit(1); }
	}
}

- (void)rollbackTransaction {
	if (topLevel == YES) {
		if (committedOrRolledback == NO) {
			committedOrRolledback = YES;
			[self executeSQL: @"ROLLBACK"];
		} else { NSLog(@"ROLLBACK: already committed or rolled back!"); exit(1); }
	}
}

- (BOOL)executeSQL:(NSString*)SQLCommand {
	return [self executeSQL: SQLCommand variables: nil];
}

- (BOOL)executeSQL:(NSString*)SQLCommand variables:(NSArray*)variables {
	char* zErrMsg = NULL;
	int rc = SQLITE_OK;
	if (variables == nil || [variables count] == 0) {
		rc = sqlite3_exec([database database], [SQLCommand UTF8String], NULL, NULL, &zErrMsg);
	} else {
		sqlite3_stmt* stmt;
		rc = sqlite3_prepare_v2([database database], [SQLCommand UTF8String], -1, &stmt, 0);
		int pos = 1;
		for (id variable in variables) {
			if ([variable isKindOfClass: [NSNumber class]]) {
				//NSLog(@"# number: %s", [variable objCType]);
				switch (*[variable objCType]) {
					case 'f':
					case 'd':
						sqlite3_bind_double(stmt, pos++, [variable doubleValue]);
						break;
					default:
						sqlite3_bind_int(stmt, pos++, [variable longValue]);
				}
			} else if ([variable isKindOfClass: [NSString class]]) {
				//NSLog(@"# string");
				sqlite3_bind_text(stmt, pos++, [variable UTF8String], -1, SQLITE_STATIC);
			}
		}
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
	}
	if (rc != SQLITE_OK) {
		NSLog(@"SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
		[NSException raise: @"Cannot execute SQL command" format: @"%@", SQLCommand];
		return NO;
	} else return YES;
}

+ (NSString*)uniqueID {
	long long uniqueID = (((long long) random()) << 32) |
	((long long) ([[NSDate date] timeIntervalSinceReferenceDate] * 1000));
	return [[NSNumber numberWithLongLong: uniqueID] description];
}

- (void)startObject:(id)obj {
	createTableSQLCommand = [[NSMutableString alloc] initWithFormat: @"CREATE TABLE IF NOT EXISTS %@ (xsid TEXT", [obj className]];
	createIndexSQLCommand = [[NSMutableString alloc] initWithFormat: @"CREATE INDEX IF NOT EXISTS idx_%@ ON %@ (xsid", [obj className], [obj className]];
	insertSQLCommand = [[NSMutableString alloc] initWithFormat: @"INSERT INTO %@ (xsid", [obj className]];
	insertSQLTail = [[NSMutableString alloc] initWithString: @"(?"];
	updateSQLCommand = [[NSMutableString alloc] initWithFormat: @"UPDATE %@ SET xsid = ?", [obj className]];
	SQLValues = [[NSMutableArray alloc] initWithObjects: [NSNull null], nil]; // dummy element - will be replaced later
	objectKey = [[NSValue valueWithPointer: obj] retain];
}

- (void)finishObject {
	[createTableSQLCommand appendString: @")"];
	[createIndexSQLCommand appendString: @")"];
	[insertSQLTail appendString: @")"];
	[insertSQLCommand appendFormat: @") VALUES %@", insertSQLTail];
		
	[self executeSQL: createTableSQLCommand];
	[self executeSQL: createIndexSQLCommand];
	NSString* objectID = [[database objectIDs] objectForKey: objectKey];
	if (objectID == nil) {
		objectID = [XSDBEncoder uniqueID];
		[SQLValues replaceObjectAtIndex: 0 withObject: objectID];
		//NSLog(@"%@", insertSQLCommand);
		//NSLog(@"%@", SQLValues);
		[self executeSQL: insertSQLCommand variables: SQLValues];
		[[database objectIDs] setObject: objectID forKey: objectKey];
	} else {
		[SQLValues replaceObjectAtIndex: 0 withObject: objectID];
		//NSLog(@"%@", updateSQLCommand);
		//NSLog(@"%@", SQLValues);
		[self executeSQL: updateSQLCommand variables: SQLValues];
	}
	
	[createTableSQLCommand release];
	[createIndexSQLCommand release];
	[insertSQLCommand release];
	[insertSQLTail release];
	[updateSQLCommand release];
	[SQLValues release];
	[objectKey release];
}

- (void)startProperty:(NSString*)name {
	propertyName = [name retain];
	[createTableSQLCommand appendFormat: @", %@ ", name];
}

- (void)finishProperty {
	[propertyName release];
}

- (void)encodeIntProperty:(int)n {
	[createTableSQLCommand appendString: @"INTEGER"];
	[createIndexSQLCommand appendFormat: @", %@", propertyName];
	[insertSQLCommand appendFormat: @", %@", propertyName];
	[insertSQLTail appendString: @", ?"];
	[updateSQLCommand appendFormat: @", %@ = ?", propertyName];
	[SQLValues addObject: [NSNumber numberWithInt: n]];
}

- (void)encodeLongProperty:(long)n { }

- (void)encodeShortProperty:(short)n { }

- (void)encodeCharProperty:(char)n { }

- (void)encodeLongLongProperty:(long long)n { }

- (void)encodeFloatProperty:(float)n { }

- (void)encodeDoubleProperty:(double)n { }

- (void)encodeStringProperty:(NSString*)text {
	[createTableSQLCommand appendString: @"TEXT"];
	[createIndexSQLCommand appendFormat: @", %@", propertyName];
	[insertSQLCommand appendFormat: @", %@", propertyName];
	[insertSQLTail appendString: @", ?"];
	[updateSQLCommand appendFormat: @", %@ = ?", propertyName];
	[SQLValues addObject: text];
}

- (void)encodeNilProperty { }

- (void)encodeArrayProperty:(NSArray*)array {
	[createTableSQLCommand appendString: @"BLOB"];
}

- (void)encodeSetProperty:(NSSet*)set { }

- (void)encodeEmbeddedObject:(id)_object {
	[createTableSQLCommand appendString: @"INTEGER"];
}

@end
