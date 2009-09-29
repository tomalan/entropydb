//
//  EXXMLParser.m
//  CRo
//
//  Created by Petr Homola on 17.10.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EXXMLParser.h"

@implementation EXXMLParser

- (id)initWithContentsOfURL:(NSURL*)url {
	NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL: url];
	return [self initWithParser: parser];
}

- (id)initWithString:(NSString*)string {
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [string dataUsingEncoding: NSUTF8StringEncoding]];
	return [self initWithParser: parser];
}

- (id)initWithContentsOfFile:(NSString*)path {
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [NSData dataWithContentsOfFile: path]];
	return [self initWithParser: parser];
}

- (id)initWithParser:(NSXMLParser*)parser {
	if (self = [super init]) {
		if (parser == nil) {
			NSLog(@"Parser error (1)");
		} else {
			[parser setDelegate: self];
			BOOL parsed = [parser parse];
			[parser release];
			if (parsed == YES) {
				succeeded = YES;
			} else {
				NSLog(@"Parser error (2)");
			}
		}
	}
	return self;
}

- (BOOL)succeeded {
	return succeeded;
}

- (EXXMLElement*)rootElement {
	return [[[EXXMLElement alloc] initWithDictionary: rootElement] autorelease];
}

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qualifiedName attributes:(NSDictionary*)attributeDict {
	//NSLog(@"did start element: %@", elementName);
	NSMutableDictionary* parentElement = temporaryElement;
	temporaryElement = [[NSMutableDictionary alloc] init];
	if (parentElement != nil) [temporaryElement setObject: parentElement forKey: @"parent"];
	[temporaryElement setObject: elementName forKey: @"name"];
	[temporaryElement setObject: attributeDict forKey: @"attributes"];
	NSMutableArray* children = [[NSMutableArray alloc] init];
	[temporaryElement setObject: children forKey: @"children"];
	[children release];
	NSString* body = [[NSMutableString alloc] init];
	[temporaryElement setObject: body forKey: @"body"];
}

- (void)parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qualifiedName {
	//NSLog(@"did end element: %@", elementName);
	//NSLog(@"...with text: '%@'", xmlText);
	NSMutableDictionary* parentElement = [temporaryElement objectForKey: @"parent"];
	if (parentElement == nil) {
		rootElement = [temporaryElement retain];
		[temporaryElement release];
		temporaryElement = nil;
	} else {
		[temporaryElement removeObjectForKey: @"parent"];
		[[parentElement objectForKey: @"children"] addObject: temporaryElement];
		[temporaryElement release];
		temporaryElement = parentElement;
	}
}

- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string {
	//NSLog(@"-- found characters: '%@'", string);
	[[temporaryElement objectForKey: @"body"] appendString: string];
	[[temporaryElement objectForKey: @"children"] addObject: string];
}

- (void)dealloc {
	[rootElement release];
	[super dealloc];
}

@end
