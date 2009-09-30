//
//  XSObjectProxy.h
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>

@interface XSObjectProxy : NSObject {
	id object;
}

- (id)__object;

@end
