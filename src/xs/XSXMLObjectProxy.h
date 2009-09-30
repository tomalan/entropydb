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
#import "XSObjectProxy.h"

@interface XSXMLObjectProxy : XSObjectProxy {
	EXXMLElement* XMLElement;
	XSComposer* composer;
	NSDictionary* attributes;
}

- (id)initWithXMLElement:(EXXMLElement*)element composer:(XSComposer*)_composer attributes:(NSDictionary*)_attributes;
- (int)__refID;

@end
