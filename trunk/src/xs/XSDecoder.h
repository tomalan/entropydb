//
//  XSDecoder.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>
#import "EXXMLElement.h"

#define kXSComposerAttribute	@"Composer"

@class XSComposer;

@interface XSDecoder : NSObject {
	NSDictionary* attributes;
	XSComposer* composer;
}

+ (XSDecoder*)XMLDecoderWithElement:(EXXMLElement*)element attributes:(NSDictionary*)_attributes;
- (id)initWithAttributes:(NSDictionary*)_attributes;
- (XSComposer*)composer;
- (int)objectID;
- (NSString*)objectClassName;
- (int)decodeIntProperty:(NSString*)name;
- (long)decodeLongProperty:(NSString*)name;
- (short)decodeShortProperty:(NSString*)name;
- (char)decodeCharProperty:(NSString*)name;
- (long long)decodeLongLongProperty:(NSString*)name;
- (float)decodeFloatProperty:(NSString*)name;
- (double)decodeDoubleProperty:(NSString*)name;
- (id)decodeObjectProperty:(NSString*)name;

@end
