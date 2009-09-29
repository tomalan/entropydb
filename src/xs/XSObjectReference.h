//
//  XSObjectReference.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XSObjectReference : NSObject {
	int refID;
}

- (id)initWithID:(int)_ID;
- (int)refID;

@end
