//
//  EXReferringElement.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under GPLv3
//

#import <Foundation/Foundation.h>

@interface EXReferringElement : NSObject {
	int objectID;
}

- (id)initWithID:(int)_id;
- (int)objectID;

@end
