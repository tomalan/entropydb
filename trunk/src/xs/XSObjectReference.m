//
//  XSObjectReference.m
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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
