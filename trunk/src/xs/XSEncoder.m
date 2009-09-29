//
//  XSEncoder.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSEncoder.h"
#import "XSXMLEncoder.h"
#import "XSDecomposer.h"

@implementation XSEncoder

- (id)initWithEncodingAttributes:(NSDictionary*)_attributes {
	if (self = [super init]) {
		attributes = [_attributes retain];
		embeddedObjects = [[NSMutableDictionary alloc] init];
	}
	return self;
}

+ (id)XMLEncoderWithEncodingAttributes:(NSDictionary*)_attributes {
	XSEncoder* encoder = [[[XSXMLEncoder alloc] initWithEncodingAttributes: _attributes] autorelease];
	[encoder startEncoding];
	return encoder;
}

- (void)startObject:(id)obj { }

- (void)finishObject:(id)obj { }

- (void)startEncoding { }

- (void)finishEncoding { }

- (void)startProperty:(NSString*)name { }

- (void)finishProperty { }

- (void)encodeIntProperty:(int)n { }

- (void)encodeStringProperty:(NSString*)text { }

- (void)encodeNilProperty { }

- (void)encodeEmbeddedObject:(id)object { }

- (XSDecomposer*)decomposer {
	if (decomposer == nil) decomposer = [attributes objectForKey: kXSDecomposerAttribute];
	return decomposer;
}

- (void)dealloc {
	[attributes release];
	[embeddedObjects release];
	[super dealloc];
}

@end
