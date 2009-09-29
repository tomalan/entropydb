//
//  XSXMLObjectProxy.h
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>
#import "EXXMLElement.h"
#import "XSComposer.h"

@interface XSXMLObjectProxy : NSObject {
	EXXMLElement* XMLElement;
	XSComposer* composer;
	NSDictionary* attributes;
	id object;
}

- (id)initWithXMLElement:(EXXMLElement*)element composer:(XSComposer*)_composer attributes:(NSDictionary*)_attributes;
- (id)__object;
- (int)__refID;

@end
