//
//  XSDecoder.m
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XSDecoder.h"
#import "XSXMLDecoder.h"
#import "XSComposer.h"

@implementation XSDecoder

+ (XSDecoder*)XMLDecoderWithElement:(EXXMLElement*)element attributes:(NSDictionary*)_attributes {
	return [[[XSXMLDecoder alloc] initWithElement: element attributes: _attributes] autorelease];
}

- (id)initWithAttributes:(NSDictionary*)_attributes {
	if (self = [super init]) {
		attributes = [_attributes retain];
	}
	return self;
}

- (XSComposer*)composer {
	if (composer == nil) composer = [attributes objectForKey: kXSComposerAttribute];
	return composer;
}

- (int)objectID { return 0; }

- (NSString*)objectClassName { return nil; }

- (int)decodeIntProperty:(NSString*)name { return 0; }

- (id)decodeObjectProperty:(NSString*)name { return nil; }

- (void)dealloc {
	[attributes release];
	[super dealloc];
}

@end
