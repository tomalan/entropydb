//
//  XSXMLDecoder.m
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XSXMLDecoder.h"
#import "XSComposer.h"
#import "XSObjectReference.h"

@implementation XSXMLDecoder

- (id)initWithElement:(EXXMLElement*)element attributes:(NSDictionary*)_attributes {
	if (self = [super initWithAttributes: _attributes]) {
		rootElement = [element retain];
		NSArray* propertyElements = [rootElement elementsWithName: @"XSProperty"];
		properties = [[NSMutableDictionary alloc] initWithCapacity: [propertyElements count]];
		for (EXXMLElement* propertyElement in propertyElements) {
			[properties setObject: propertyElement forKey: [propertyElement attributeWithName: @"name"]];
		}
	}
	return self;
}

- (int)objectID {
	return [[rootElement attributeWithName: @"id"] intValue];
}

- (NSString*)objectClassName {
	return [rootElement attributeWithName: @"class"];
}

- (int)decodeIntProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return [[propertyElement body] intValue];
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
		return 0;
	}
}

- (id)decodeObjectProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		NSString* type = [propertyElement attributeWithName: @"type"];
		if ([type isEqual: @"nil"] == YES) {
			return nil;
		} else if ([type isEqual: @"string"] == YES) {
			return [propertyElement body];
		} else {
			NSString* refID = [propertyElement attributeWithName: @"refID"];
			if (refID != nil) {
				return [[[XSObjectReference alloc] initWithID: [refID intValue]] autorelease];
			} else {
				XSDecoder* decoder = [XSDecoder XMLDecoderWithElement: [propertyElement firstElementWithName: @"XSObject"]
														   attributes: attributes];
				id obj = [[self composer] composeObjectWithDecoder: decoder];
				return obj;
			}
		}
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
	}
	return nil;
}

- (void)dealloc {
	[rootElement release];
	[properties release];
	[super dealloc];
}

@end
