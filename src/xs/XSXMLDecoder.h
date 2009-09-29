//
//  XSXMLDecoder.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
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
