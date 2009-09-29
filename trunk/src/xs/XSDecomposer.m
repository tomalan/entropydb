//
//  XSDecomposer.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
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
			} else if ([type isEqual: @"l"]) {
				long value = *(long*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeLongProperty: value];
			} else if ([type isEqual: @"L"]) {
				unsigned long value = *(unsigned long*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeLongProperty: value];
			} else if ([type isEqual: @"s"]) {
				short value = *(short*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeShortProperty: value];
			} else if ([type isEqual: @"S"]) {
				unsigned short value = *(unsigned short*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeShortProperty: value];
			} else if ([type isEqual: @"c"]) {
				char value = *(char*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeCharProperty: value];
			} else if ([type isEqual: @"C"]) {
				unsigned char value = *(unsigned char*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeCharProperty: value];
			} else if ([type isEqual: @"q"]) {
				long long value = *(long long*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeLongLongProperty: value];
			} else if ([type isEqual: @"Q"]) {
				unsigned long long value = *(unsigned long long*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeLongLongProperty: value];
			} else if ([type isEqual: @"f"]) {
				float value = *(float*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeFloatProperty: value];
			} else if ([type isEqual: @"d"]) {
				double value = *(double*)((void*)obj + ivar_getOffset(*ivar));
				[encoder encodeDoubleProperty: value];
			} else if ([type characterAtIndex: 0] == '@') {
				id value = object_getIvar(obj, *ivar);
				if (value == nil) {
					[encoder encodeNilProperty];
				} else if ([value isKindOfClass: [NSString class]]) {
					[encoder encodeStringProperty: value];
				} else if ([value isKindOfClass: [NSArray class]]) {
					[encoder encodeArrayProperty: value];
				} else if ([value isKindOfClass: [NSSet class]]) {
					[encoder encodeSetProperty: value];
				//} else if ([value isKindOfClass: [NSDictionary class]]) {
				//	[encoder encodeDictionaryProperty: value];
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
	[encoder finishObject];
}

@end
