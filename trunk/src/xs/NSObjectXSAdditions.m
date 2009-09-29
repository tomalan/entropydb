//
//  NSStringXSAdditions.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "NSObjectXSAdditions.h"
#import "XSHelper.h"

@implementation NSObject (XSAdditions)

- (NSString*)XMLString {
	return [XSHelper serializeObjectToXMLString: self];
}

- (BOOL)writeToFile:(NSString*)path {
	return [XSHelper serializeObject: self toFile: path];
}

+ (id)buildObjectFromXMLString:(NSString*)XMLString {
	return [XSHelper deserializeObjectFromXMLString: XMLString];
}

+ (id)buildObjectFromXMLFile:(NSString*)path {
	return [XSHelper deserializeObjectFromXMLFile: path];
}

- (BOOL)writeToFileInDocumentsDirectory:(NSString*)path {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex: 0];
	path = [@"/" stringByAppendingString: path];
	path = [documentsDirectory stringByAppendingString: path];
	return [self writeToFile: path];
}

+ (id)buildObjectFromXMLFileInDocumentsDirectory:(NSString*)path {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex: 0];
	path = [@"/" stringByAppendingString: path];
	path = [documentsDirectory stringByAppendingString: path];
	return [self buildObjectFromXMLFile: path];
}

@end
