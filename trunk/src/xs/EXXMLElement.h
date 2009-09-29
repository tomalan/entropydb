//
//  EXXMLElement.h
//  CRo
//
//  Created by Petr Homola on 17.10.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXXMLElement : NSObject {
	NSDictionary* dictionary;
}

- (id)initWithDictionary:(NSDictionary*)_dictionary;
- (NSArray*)elementsWithName:(NSString*)name;
- (EXXMLElement*)firstElementWithName:(NSString*)name;
- (NSString*)name;
- (NSString*)body;
- (NSArray*)children;
- (NSArray*)wrappedChildren;
- (NSString*)attributeWithName:(NSString*)name;

@end
