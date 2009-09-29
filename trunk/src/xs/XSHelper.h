//
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>

@interface XSHelper : NSObject {

}

+ (NSString*)serializeObjectToXMLString:(id)obj;
+ (BOOL)serializeObject:(id)obj toFile:(NSString*)path;
+ (id)deserializeObjectFromXMLString:(NSString*)XMLAsString;

@end
