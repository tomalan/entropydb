//
//  XSXMLObjectProxy.m
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSXMLObjectProxy.h"
#import "XSDecoder.h"

@implementation XSXMLObjectProxy

- (id)initWithXMLElement:(EXXMLElement*)element composer:(XSComposer*)_composer attributes:(NSDictionary*)_attributes {
	if (self = [super init]) {
		XMLElement = [element retain];
		composer = [_composer retain];
		attributes = [_attributes retain];
	}
	return self;
}

- (id)__object {
	if (object == nil) {
		XSDecoder* decoder = [XSDecoder XMLDecoderWithElement: XMLElement attributes: attributes];
		object = [[composer composeObjectWithDecoder: decoder forceInitialization: YES] retain];
		[XMLElement release];
		[composer release];
		[attributes release];
		XMLElement = nil;
		composer = nil;
		attributes = nil;
	}
	return object;
}

- (int)__refID {
	return [[XMLElement attributeWithName: @"id"] intValue];
}

- (void)dealloc {
	[XMLElement release];
	[composer release];
	[attributes release];
	[super dealloc];
}

@end
