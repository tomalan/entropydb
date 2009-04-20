//
//  EXPredicateEqualInt.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import "EXPredicate.h"

@interface EXPredicateEqualInt : EXPredicate {
	int value;
}

- (id)initWithFieldName:(NSString*)_fieldName intValue:(int)_value;
- (int)intValue;

@end
