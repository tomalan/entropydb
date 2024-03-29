//
//  XSPredicateInspector.m
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import "XSPredicateInspector.h"

@implementation XSPredicateInspector

+ (NSString*)inspectPredicate:(NSPredicate*)predicate arguments:(NSArray**)arguments {
	XSPredicateInspector* predicateInspector = [[[XSPredicateInspector alloc] init] autorelease];
	NSMutableString* code = [NSMutableString string];
	NSMutableArray* _arguments = [NSMutableArray array];
	if ([predicateInspector inspectPredicate: predicate code: code arguments: _arguments] == YES) {
		*arguments = [[_arguments copy] autorelease];
		return code;
	} else return nil;
}

- (BOOL)inspectPredicate:(id)predicate code:(NSMutableString*)code arguments:(NSMutableArray*)arguments {
	if ([predicate isKindOfClass: [NSCompoundPredicate class]]) {
		if ([predicate compoundPredicateType] == NSNotPredicateType) {
			[code appendString: @"(NOT "];
			[self inspectPredicate: [[predicate subpredicates] objectAtIndex: 0] code: code arguments: arguments];
			[code appendString: @")"];
			return YES;
		} else if ([predicate compoundPredicateType] == NSAndPredicateType) {
			[code appendString: @"("];
			NSArray* subpredicates = [predicate subpredicates];
			for (int i = 0; i < [subpredicates count]; i++) {
				if (i > 0) [code appendString: @" AND "];
				NSPredicate* subpredicate = [subpredicates objectAtIndex: i];
				[self inspectPredicate: subpredicate code: code arguments: arguments];
			}
			[code appendString: @")"];
			return YES;
		} else if ([predicate compoundPredicateType] == NSOrPredicateType) {
			[code appendString: @"("];
			NSArray* subpredicates = [predicate subpredicates];
			for (int i = 0; i < [subpredicates count]; i++) {
				if (i > 0) [code appendString: @" OR "];
				NSPredicate* subpredicate = [subpredicates objectAtIndex: i];
				[self inspectPredicate: subpredicate code: code arguments: arguments];
			}
			[code appendString: @")"];
			return YES;
		} else NSLog(@"Unknown compound type");
	} else if ([predicate isKindOfClass: [NSComparisonPredicate class]]) {
		if ([predicate predicateOperatorType] == NSEqualToPredicateOperatorType
			&& [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
			&& [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" = "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else if ([predicate predicateOperatorType] == NSNotEqualToPredicateOperatorType
			&& [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
			&& [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" <> "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else if ([predicate predicateOperatorType] == NSLikePredicateOperatorType
				   && [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
				   && [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" LIKE "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else if ([predicate predicateOperatorType] == NSLessThanPredicateOperatorType
				   && [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
				   && [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" < "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else if ([predicate predicateOperatorType] == NSLessThanOrEqualToPredicateOperatorType
				   && [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
				   && [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" <= "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else if ([predicate predicateOperatorType] == NSGreaterThanPredicateOperatorType
				   && [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
				   && [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" > "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else if ([predicate predicateOperatorType] == NSGreaterThanOrEqualToPredicateOperatorType
				   && [predicate comparisonPredicateModifier] == NSDirectPredicateModifier
				   && [predicate options] == 0) {
			if ([self inspectExpression: [predicate leftExpression] code: code arguments: arguments] == NO) return NO;
			[code appendString: @" >= "];
			if ([self inspectExpression: [predicate rightExpression] code: code arguments: arguments] == NO) return NO;
			return YES;
		} else NSLog(@"Unknown operator type");
	}
	return NO;
}

- (BOOL)inspectExpression:(NSExpression*)expression code:(NSMutableString*)code arguments:(NSMutableArray*)arguments {
	if ([expression expressionType] == NSConstantValueExpressionType) {
		[code appendString: @"?"];
		[arguments addObject: [expression constantValue]];
		return YES;
	} else if ([expression expressionType] == NSKeyPathExpressionType) {
		NSString* keyPath = [expression keyPath];
		//if ([keyPath rangeOfString: @"."].location != NSNotFound) return NO;
		[code appendFormat: @"%@", keyPath];
		return YES;
	} else NSLog(@"Unknown expression type");
	return NO;
}

@end
