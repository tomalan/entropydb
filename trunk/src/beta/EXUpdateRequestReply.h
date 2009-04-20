//
//  EXUpdateRequestReply.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import <Foundation/Foundation.h>

@interface EXUpdateRequestReply : NSObject {
	NSTimeInterval lastSyncedUpdate;
	NSArray* updates;
}

- (id)initWithLastSyncedUpdate:(NSTimeInterval)timeInterval updates:(NSArray*)_updates;
- (NSTimeInterval)lastSyncedUpdate;
- (NSArray*)updates;

@end
