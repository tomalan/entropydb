//
//  XSComposer.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <objc/runtime.h>
#import "XSComposer.h"
#import "XSObjectReference.h"

@implementation XSComposer

- (id)init {
	if (self = [super init]) {
		embeddedObjects = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (id)composeObjectWithDecoder:(XSDecoder*)decoder {
	int ID = [decoder objectID];
	NSNumber* key = [NSNumber numberWithInt: ID];
	id obj = [embeddedObjects objectForKey: key];
	if (obj == nil) {
		Class cls = NSClassFromString([decoder objectClassName]);
		obj = [[[cls alloc] init] autorelease];
		[embeddedObjects setObject: obj forKey: key];
		while (cls != [NSObject class]) {
			unsigned count, i;
			Ivar* firstIvar = class_copyIvarList(cls, &count);
			for (i = 0; i < count; i++) {
				Ivar* ivar = firstIvar + i;
				NSString* name = [NSString stringWithUTF8String: ivar_getName(*ivar)];
				NSString* type = [NSString stringWithUTF8String: ivar_getTypeEncoding(*ivar)];
				if ([type isEqual: @"i"]) {
					int value = [decoder decodeIntProperty: name];
					*(int*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"I"]) {
					int value = [decoder decodeIntProperty: name];
					*(unsigned*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"l"]) {
					long value = [decoder decodeLongProperty: name];
					*(long*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"L"]) {
					long value = [decoder decodeLongProperty: name];
					*(unsigned long*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"s"]) {
					short value = [decoder decodeShortProperty: name];
					*(short*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"S"]) {
					short value = [decoder decodeShortProperty: name];
					*(unsigned short*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"c"]) {
					char value = [decoder decodeCharProperty: name];
					*(char*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"C"]) {
					char value = [decoder decodeCharProperty: name];
					*(unsigned char*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"q"]) {
					long long value = [decoder decodeLongLongProperty: name];
					*(long long*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"Q"]) {
					long long value = [decoder decodeLongLongProperty: name];
					*(unsigned long long*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"f"]) {
					float value = [decoder decodeFloatProperty: name];
					*(float*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type isEqual: @"d"]) {
					double value = [decoder decodeDoubleProperty: name];
					*(double*)((void*)obj + ivar_getOffset(*ivar)) = value;
				} else if ([type characterAtIndex: 0] == '@') {
					id value = [decoder decodeObjectProperty: name];
					if ([value isKindOfClass: [XSObjectReference class]]) {
						NSNumber* key = [NSNumber numberWithInt: [value refID]];
						value = [embeddedObjects objectForKey: key];
					} else if ([value isKindOfClass: [NSArray class]]) {
						NSArray* oldArray = value;
						value = [NSMutableArray arrayWithCapacity: [oldArray count]];
						for (id obj in oldArray) {
							if ([obj isKindOfClass: [XSObjectReference class]]) {
								NSNumber* key = [NSNumber numberWithInt: [obj refID]];
								obj = [embeddedObjects objectForKey: key];
							}
							[value addObject: obj];
						}
					}
					object_setIvar(obj, *ivar, [value retain]);
				} else {
					[NSException raise: @"Unknown property type" format: @"Property: %@", name];
				}
			}
			free(firstIvar);
			cls = [cls superclass];
		}
	}
	return obj;
}

- (void)dealloc {
	[embeddedObjects release];
	[super dealloc];
}

@end
