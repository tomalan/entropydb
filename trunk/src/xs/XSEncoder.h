//
//  XSEncoder.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>

#define kXSStringBuilderAttribute	@"StringBuilder"
#define kXSDecomposerAttribute		@"Decomposer"

@class XSDecomposer;

@interface XSEncoder : NSObject {
	NSDictionary* attributes;
	XSDecomposer* decomposer;
	NSMutableDictionary* embeddedObjects;
}

- (id)initWithEncodingAttributes:(NSDictionary*)_attributes;
+ (id)XMLEncoderWithEncodingAttributes:(NSDictionary*)_attributes;
- (void)startObject:(id)obj;
- (void)finishObject:(id)obj;
- (void)startProperty:(NSString*)name;
- (void)finishProperty;
- (void)encodeIntProperty:(int)n;
- (void)encodeStringProperty:(NSString*)text;
- (void)encodeNilProperty;
- (void)encodeEmbeddedObject:(id)object;
- (void)startEncoding;
- (void)finishEncoding;
- (XSDecomposer*)decomposer;

@end
