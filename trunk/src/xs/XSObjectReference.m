//
//  XSObjectReference.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSObjectReference.h"

@implementation XSObjectReference

- (id)initWithID:(int)_ID {
	if (self = [super init]) {
		refID = _ID;
	}
	return self;
}

- (int)refID {
	return refID;
}

@end
