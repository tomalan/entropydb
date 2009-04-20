//
//  EXReferringElement.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import <Foundation/Foundation.h>

@interface EXReferringElement : NSObject {
	int objectID;
}

- (id)initWithID:(int)_id;
- (int)objectID;

@end
