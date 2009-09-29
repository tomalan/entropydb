//
//  XSHelper.h
//  test
//
//  Created by Petr Homola on 28.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XSHelper : NSObject {

}

+ (NSString*)serializeObjectToXMLString:(id)obj;
+ (BOOL)serializeObject:(id)obj toFile:(NSString*)path;
+ (id)deserializeObjectFromXMLString:(NSString*)XMLAsString;

@end
