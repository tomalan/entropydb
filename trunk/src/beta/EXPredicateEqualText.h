//
//  EXPredicateEqualText.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import "EXPredicate.h"

@interface EXPredicateEqualText : EXPredicate {
	NSString* value;
}

- (id)initWithFieldName:(NSString*)_fieldName value:(NSString*)_value;
- (NSString*)textValue;

@end
