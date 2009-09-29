//
//  EXXMLParser.h
//  CRo
//
//  Created by Petr Homola on 17.10.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
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
