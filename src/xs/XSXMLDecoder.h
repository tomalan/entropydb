//
//  XSXMLDecoder.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XSDecoder.h"
#import "EXXMLElement.h"

@interface XSXMLDecoder : XSDecoder {
	EXXMLElement* rootElement;
	NSMutableDictionary* properties;
}

- (id)initWithElement:(EXXMLElement*)element attributes:(NSDictionary*)_attributes;

@end
