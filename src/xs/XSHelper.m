//
//  XSHelper.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSHelper.h"
#import "XSDecomposer.h"
#import "XSEncoder.h"
#import "XSComposer.h"
#import "XSDecoder.h"
#import "EXXMLParser.h"

@implementation XSHelper

+ (NSString*)serializeObjectToXMLString:(id)obj {
	NSMutableString* XMLString = [NSMutableString string];
	XSDecomposer* decomposer = [[[XSDecomposer alloc] init] autorelease];
	NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								XMLString, kXSStringBuilderAttribute,
								decomposer, kXSDecomposerAttribute, nil];
	XSEncoder* encoder = [XSEncoder XMLEncoderWithEncodingAttributes: attributes];
	[decomposer decomposeObject: obj encoder: encoder];
	[encoder finishEncoding];
	return XMLString;
}

+ (BOOL)serializeObject:(id)obj toFile:(NSString*)path {
	NSString* XMLAsString = [self serializeObjectToXMLString: obj];
	NSError* error;
	return [XMLAsString writeToFile: path atomically: YES encoding: NSUTF8StringEncoding error: &error];
}

+ (id)deserializeObjectFromXMLString:(NSString*)XMLAsString {
	EXXMLParser* parser = [[[EXXMLParser alloc] initWithString: XMLAsString] autorelease];
	if ([parser succeeded] == YES) {
		XSComposer* composer = [[[XSComposer alloc] init] autorelease];
		NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
									composer, kXSComposerAttribute, nil];
		XSDecoder* decoder = [XSDecoder XMLDecoderWithElement: [[parser rootElement] firstElementWithName: @"XSObject"]
												   attributes: attributes];
		id obj = [composer composeObjectWithDecoder: decoder];
		return obj;
	} else return nil;
}

@end
