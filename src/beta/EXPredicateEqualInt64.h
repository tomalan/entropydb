//
//  EXPredicateEqualInt64.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import "EXPredicate.h"

@interface EXPredicateEqualInt64 : EXPredicate {
	long long value;
}

- (id)initWithFieldName:(NSString*)_fieldName int64Value:(long long)_value;

@end
