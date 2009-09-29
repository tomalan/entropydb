//
//  EXXMLElement.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "EXXMLElement.h"

@implementation EXXMLElement

- (id)initWithDictionary:(NSDictionary*)_dictionary {
	if (self = [super init]) {
		dictionary = [_dictionary retain];
	}
	return self;
}

- (NSArray*)elementsWithName:(NSString*)name {
	NSMutableArray* result = [NSMutableArray array];
	for (id child in [dictionary objectForKey: @"children"]) {
		if ([child isKindOfClass: [NSDictionary class]]) {
			if ([[child objectForKey: @"name"] isEqual: name]) {
				EXXMLElement* element = [[EXXMLElement alloc] initWithDictionary: child];
				[result addObject: element];
				[element release];
			}
		}
	}
	return result;
}

- (NSArray*)wrappedChildren {
	NSMutableArray* result = [NSMutableArray array];
	for (id child in [dictionary objectForKey: @"children"]) {
		if ([child isKindOfClass: [NSDictionary class]]) {
			EXXMLElement* element = [[EXXMLElement alloc] initWithDictionary: child];
			[result addObject: element];
			[element release];
		} else [result addObject: child];
	}
	return result;
}

- (EXXMLElement*)firstElementWithName:(NSString*)name {
	NSArray* elements = [self elementsWithName: name];
	return [elements count] > 0 ? [elements objectAtIndex: 0] : nil;
}

- (NSString*)name {
	return [dictionary objectForKey: @"name"];
}

- (NSString*)body {
	return [dictionary objectForKey: @"body"];
}

- (NSArray*)children {
	return [dictionary objectForKey: @"children"];
}

- (NSString*)attributeWithName:(NSString*)name {
	return [[dictionary objectForKey: @"attributes"] objectForKey: name];
}

- (NSString*)description {
	return [NSString stringWithFormat: @"%@ -- '%@' %@", [self name], [self body], [self children]];
}

- (void)dealloc {
	[dictionary release];
	[super dealloc];
}

@end
