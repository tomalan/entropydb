//
//  EXPersistentObject.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import <Foundation/Foundation.h>

@class EXContainer;

@interface EXPersistentObject : NSObject {
	EXContainer* container;
}

- (void)setContainer:(EXContainer*)_container;
- (void)store;

@end
