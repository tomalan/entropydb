//
//  NSStringXSAdditions.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>

@interface NSObject (XSAdditions)

- (NSString*)XMLString;
- (BOOL)writeToFile:(NSString*)path;
+ (id)buildObjectFromXMLString:(NSString*)XMLString;
+ (id)buildObjectFromXMLFile:(NSString*)path;
- (BOOL)writeToFileInDocumentsDirectory:(NSString*)path;
+ (id)buildObjectFromXMLFileInDocumentsDirectory:(NSString*)path;

@end
