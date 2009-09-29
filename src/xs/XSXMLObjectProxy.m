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

- (NSString*)className {
	return [[self __object] className];
}

- (NSString*)description {
	id _object = [self __object];
	NSString* desc = [_object description];
	return desc; /*/ [NSString stringWithFormat: @"(XML proxy) %@", desc]; /**/
}

- (BOOL)isKindOfClass:(Class)cls {
	return [[self __object] isKindOfClass: cls];
}

- (BOOL)isMemberOfClass:(Class)cls {
	return [[self __object] isMemberOfClass: cls];
}

- (void)encodeWithCoder:(NSCoder*)coder {
	[[self __object] encodeWithCoder: coder];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
	NSMethodSignature* signature = [super methodSignatureForSelector: selector];
	if (signature) return signature;
	signature = [[self __object] methodSignatureForSelector: selector];
	if (signature == nil) NSLog(@"the wrapped object doesn't recognize the forwarded selector");
	return signature;
}

- (void)forwardInvocation:(NSInvocation*)invocation {
	if ([object respondsToSelector: [invocation selector]]) [invocation invokeWithTarget: object];
	else [self doesNotRecognizeSelector: [invocation selector]];
}

- (void)dealloc {
	[XMLElement release];
	[composer release];
	[attributes release];
	[object release];
	[super dealloc];
}

@end
