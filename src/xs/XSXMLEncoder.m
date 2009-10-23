//
//  XSXMLEncoder.m
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSXMLEncoder.h"
#import "XSDecomposer.h"

@implementation XSXMLEncoder

- (NSMutableString*)XMLString {
	if (XMLString == nil) XMLString = [attributes objectForKey: kXSStringBuilderAttribute];
	return XMLString;
}

- (void)startObject:(id)obj {
	[[self XMLString] appendFormat: @"<XSObject id=\"%d\" class=\"%@\">\n", nextFreeObjectID++, [obj className]];
}

- (void)finishObject {
	[[self XMLString] appendString: @"</XSObject>\n"];
}

- (void)startEncoding {
	[[self XMLString] appendString: @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];
	[[self XMLString] appendString: @"<XSObjects>\n"];
}

- (void)finishEncoding {
	[[self XMLString] appendString: @"</XSObjects>\n"];
}

- (void)startProperty:(NSString*)name {
	[[self XMLString] appendFormat: @"<XSProperty name=\"%@\" ", name];
}

- (void)finishProperty {
	[[self XMLString] appendString: @"</XSProperty>\n"];
}

- (void)encodeIntProperty:(int)n {
	[[self XMLString] appendFormat: @"type=\"int\">%d", n];
}

- (void)encodeLongProperty:(long)n {
	[[self XMLString] appendFormat: @"type=\"long\">%ld", n];
}

- (void)encodeShortProperty:(short)n {
	[[self XMLString] appendFormat: @"type=\"short\">%d", n];
}

- (void)encodeCharProperty:(char)n {
	[[self XMLString] appendFormat: @"type=\"char\">%d", (int) n];
}

- (void)encodeLongLongProperty:(long long)n {
	[[self XMLString] appendFormat: @"type=\"long long\">%lld", n];
}

- (void)encodeFloatProperty:(float)n {
	[[self XMLString] appendFormat: @"type=\"float\">%f", (int) n];
}

- (void)encodeDoubleProperty:(double)n {
	[[self XMLString] appendFormat: @"type=\"double\">%lf", (int) n];
}


- (void)encodeStringProperty:(NSString*)text {
	[[self XMLString] appendFormat: @"type=\"string\">%@", [self encodeString: text]];
}

- (void)encodeNilProperty {
	[[self XMLString] appendString: @"type=\"nil\">"];
}

- (void)encodeArrayProperty:(NSArray*)array {
	[[self XMLString] appendFormat: @"type=\"array\" mutable=\"%d\">\n", [array isKindOfClass: [NSMutableArray class]]];
	for (id object in array) {
		NSValue* key = [NSValue valueWithPointer: object];
		NSNumber* refID = [embeddedObjects objectForKey: key];
		if (refID == nil) {
			[embeddedObjects setObject: [NSNumber numberWithInt: nextFreeObjectID] forKey: key];
			[[self decomposer] decomposeObject: object encoder: self];
		} else {
			[[self XMLString] appendFormat: @"<XSObject refID=\"%@\"/>\n", refID];
		}
	}
}

- (void)encodeDictionaryProperty:(NSDictionary*)dict {
	[[self XMLString] appendFormat: @"type=\"dictionary\" mutable=\"%d\">\n", [dict isKindOfClass: [NSMutableDictionary class]]];
	for (id entryKey in [dict allKeys]) {
		[[self XMLString] appendString: @"<XSEntry>\n"];
		
		NSValue* key = [NSValue valueWithPointer: entryKey];
		NSNumber* refID = [embeddedObjects objectForKey: key];
		if (refID == nil) {
			[embeddedObjects setObject: [NSNumber numberWithInt: nextFreeObjectID] forKey: key];
			[[self decomposer] decomposeObject: entryKey encoder: self];
		} else {
			[[self XMLString] appendFormat: @"<XSObject refID=\"%@\"/>\n", refID];
		}
		
		id entryValue = [dict objectForKey: entryKey];
		key = [NSValue valueWithPointer: entryValue];
		refID = [embeddedObjects objectForKey: key];
		if (refID == nil) {
			[embeddedObjects setObject: [NSNumber numberWithInt: nextFreeObjectID] forKey: key];
			[[self decomposer] decomposeObject: entryValue encoder: self];
		} else {
			[[self XMLString] appendFormat: @"<XSObject refID=\"%@\"/>\n", refID];
		}
		
		[[self XMLString] appendString: @"</XSEntry>\n"];
	}
}

- (void)encodeSetProperty:(NSSet*)set {
	[[self XMLString] appendFormat: @"type=\"set\" mutable=\"%d\">\n", [set isKindOfClass: [NSMutableSet class]]];
	for (id object in set) {
		NSValue* key = [NSValue valueWithPointer: object];
		NSNumber* refID = [embeddedObjects objectForKey: key];
		if (refID == nil) {
			[embeddedObjects setObject: [NSNumber numberWithInt: nextFreeObjectID] forKey: key];
			[[self decomposer] decomposeObject: object encoder: self];
		} else {
			[[self XMLString] appendFormat: @"<XSObject refID=\"%@\"/>\n", refID];
		}
	}
}

- (void)encodeEmbeddedObject:(id)object {
	NSValue* key = [NSValue valueWithPointer: object];
	NSNumber* refID = [embeddedObjects objectForKey: key];
	if (refID == nil) {
		[[self XMLString] appendString: @"type=\"object\">\n"];
		[embeddedObjects setObject: [NSNumber numberWithInt: nextFreeObjectID] forKey: key];
		[[self decomposer] decomposeObject: object encoder: self];
	} else {
		[[self XMLString] appendFormat: @"type=\"object\" refID=\"%@\">\n", refID];
	}
}

- (NSString*)encodeString:(NSString*)text {
	text = [text stringByReplacingOccurrencesOfString: @"<" withString: @"&lt;"];
	text = [text stringByReplacingOccurrencesOfString: @">" withString: @"&gt;"];
	text = [text stringByReplacingOccurrencesOfString: @"&" withString: @"&amp;"];
	return text;
}

@end
