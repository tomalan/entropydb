//
//  XSXMLEncoder.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XSEncoder.h"

@interface XSXMLEncoder : XSEncoder {
	NSMutableString* XMLString;
	int nextFreeObjectID;
}

- (NSMutableString*)XMLString;
- (NSString*)encodeString:(NSString*)text;

@end
