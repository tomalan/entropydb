//
//  XSXMLDecoder.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
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

- (long)decodeLongProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return atol([[propertyElement body] cStringUsingEncoding: NSUTF8StringEncoding]);
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
		return 0;
	}
}

- (short)decodeShortProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return [[propertyElement body] intValue];
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
		return 0;
	}
}

- (char)decodeCharProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return (char) [[propertyElement body] intValue];
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
		return 0;
	}
}

- (long long)decodeLongLongProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return [[propertyElement body] longLongValue];
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
		return 0;
	}
}

- (float)decodeFloatProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return [[propertyElement body] floatValue];
	} else {
		[NSException raise: @"Property not found" format: @"Name: %@", name];
		return 0;
	}
}

- (double)decodeDoubleProperty:(NSString*)name {
	EXXMLElement* propertyElement = [properties objectForKey: name];
	if (propertyElement != nil) {
		return [[propertyElement body] doubleValue];
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
		} else if ([type isEqual: @"array"] == YES) {
			NSArray* elements = [propertyElement elementsWithName: @"XSObject"];
			NSMutableArray* value = [NSMutableArray arrayWithCapacity: [elements count]];
			for (EXXMLElement* element in elements) {
				NSString* refID = [element attributeWithName: @"refID"];
				if (refID != nil) {
					[value addObject: [[[XSObjectReference alloc] initWithID: [refID intValue]] autorelease]];
				} else {
					XSDecoder* decoder = [XSDecoder XMLDecoderWithElement: element attributes: attributes];
					id obj = [[self composer] composeObjectWithDecoder: decoder];
					[value addObject: obj];
				}
			}
			return value;
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
