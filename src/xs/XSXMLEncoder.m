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
	[[self XMLString] appendFormat: @"\t<XSObject id=\"%d\" class=\"%@\">\n", nextFreeObjectID++, [obj className]];
}

- (void)finishObject:(id)obj {
	[[self XMLString] appendString: @"\t</XSObject>\n"];
}

- (void)startEncoding {
	[[self XMLString] appendString: @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];
	[[self XMLString] appendString: @"<XSObjects>\n"];
}

- (void)finishEncoding {
	[[self XMLString] appendString: @"</XSObjects>\n"];
}

- (void)startProperty:(NSString*)name {
	[[self XMLString] appendFormat: @"\t\t<XSProperty name=\"%@\" ", name];
}

- (void)finishProperty {
	[[self XMLString] appendString: @"</XSProperty>\n"];
}

- (void)encodeIntProperty:(int)n {
	[[self XMLString] appendFormat: @"type=\"int\">%d", n];
}

- (void)encodeStringProperty:(NSString*)text {
	[[self XMLString] appendFormat: @"type=\"string\">%@", [self encodeString: text]];
}

- (void)encodeNilProperty {
	[[self XMLString] appendString: @"type=\"nil\">"];
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
