//
//  EXXMLParser.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Foundation/Foundation.h>
#import "EXXMLElement.h"

@interface EXXMLParser : NSObject <NSXMLParserDelegate> {
	BOOL succeeded;
	NSDictionary* rootElement;
	NSMutableDictionary* temporaryElement;
	//NSMutableString* xmlText;
}

- (id)initWithContentsOfURL:(NSURL*)url;
- (id)initWithContentsOfFile:(NSString*)path;
- (id)initWithString:(NSString*)string;
- (id)initWithParser:(NSXMLParser*)parser;
- (BOOL)succeeded;
- (EXXMLElement*)rootElement;

@end
