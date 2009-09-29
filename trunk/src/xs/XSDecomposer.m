//
//  XSDecomposer.m
//  test
//
//  Created by Petr Homola on 28.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "XSDecomposer.h"

@implementation XSDecomposer

- (void)decomposeObject:(id)obj encoder:(XSEncoder*)encoder {
	[encoder startObject: obj];
	Class cls = [obj class];
	while (cls != [NSObject class]) {
		unsigned count, i;
		Ivar* firstIvar = class_copyIvarList(cls, &count);
		for (i = 0; i < count; i++) {
			Ivar* ivar = firstIvar + i;
			NSString* name = [NSString stringWithUTF8String: ivar_getName(*ivar)];
			[encoder startProperty: name];
			NSString* type = [NSString stringWithUTF8String: ivar_getTypeEncoding(*ivar)];
			if ([type isEqual: @"i"]) {
				int value = *(int*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeIntProperty: value];
			} else if ([type isEqual: @"I"]) {
				unsigned value = *(unsigned*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeIntProperty: value];
			} else if ([type characterAtIndex: 0] == '@') {
				id value = object_getIvar(obj, *ivar);
				if (value == nil) {
					[encoder encodeNilProperty];
				} else if ([value isKindOfClass: [NSString class]]) {
					[encoder encodeStringProperty: value];
				} else {
					[encoder encodeEmbeddedObject: value];
				}
			} else {
				[NSException raise: @"Unknown property type" format: @"Property: %@", name];
			}
			[encoder finishProperty];
		}
		free(firstIvar);
		cls = [cls superclass];
	}
	[encoder finishObject: obj];
}

@end
