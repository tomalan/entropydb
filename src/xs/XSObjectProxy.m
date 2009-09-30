//
//  XSObjectProxy.m
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSObjectProxy.h"

@implementation XSObjectProxy

- (id)__object {
	return object;
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
	[object release];
	[super dealloc];
}

@end
