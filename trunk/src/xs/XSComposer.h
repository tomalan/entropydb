//
//  XSComposer.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XSDecoder.h"

@interface XSComposer : NSObject {
	NSMutableDictionary* embeddedObjects;
}

- (id)composeObjectWithDecoder:(XSDecoder*)decoder;

@end
