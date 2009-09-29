//
//  XSDecoder.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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
- (id)decodeObjectProperty:(NSString*)name;

@end
