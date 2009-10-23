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

- (void)finishObject { }

- (void)startEncoding { }

- (void)finishEncoding { }

- (void)startProperty:(NSString*)name { }

- (void)finishProperty { }

- (void)encodeIntProperty:(int)n { }

- (void)encodeLongProperty:(long)n { }

- (void)encodeShortProperty:(short)n { }

- (void)encodeCharProperty:(char)n { }

- (void)encodeLongLongProperty:(long long)n { }

- (void)encodeFloatProperty:(float)n { }

- (void)encodeDoubleProperty:(double)n { }

- (void)encodeStringProperty:(NSString*)text { }

- (void)encodeNilProperty { }

- (void)encodeArrayProperty:(NSArray*)array { }

- (void)encodeDictionaryProperty:(NSDictionary*)dict { }

- (void)encodeSetProperty:(NSSet*)set { }

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
