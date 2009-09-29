//
//  XSComposer.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>
#import "XSDecoder.h"

@interface XSComposer : NSObject {
	NSMutableDictionary* embeddedObjects;
}

- (id)composeObjectWithDecoder:(XSDecoder*)decoder;
- (id)composeObjectWithDecoder:(XSDecoder*)decoder forceInitialization:(BOOL)forceInitialization;

@end
