//
//  EXGlobalSyncInfo.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import <Foundation/Foundation.h>

@interface EXGlobalSyncInfo : NSObject {
	NSTimeInterval lastIncomingSync;
	NSString* containerIdentifier;
}

- (id)initWithContainerIdentifier:(NSString*)_containerIdentifier;
- (NSString*)containerIdentifier;
- (void)setLastIncomingSync:(NSTimeInterval)timeInterval;
- (NSTimeInterval)lastIncomingSync;

@end