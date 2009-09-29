//
//  EXXMLElement.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
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
