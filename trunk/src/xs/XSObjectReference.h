//
//  XSObjectReference.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>

@interface XSObjectReference : NSObject {
	int refID;
}

- (id)initWithID:(int)_ID;
- (int)refID;

@end
