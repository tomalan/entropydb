//
//  XSEncoder.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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
