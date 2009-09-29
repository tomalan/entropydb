//
//  XSXMLEncoder.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
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
