//
//  XSPredicateInspector.h
//  test
//
//  Created by Petr Homola on 29.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XSPredicateInspector : NSObject {

}

+ (NSString*)inspectPredicate:(NSPredicate*)predicate arguments:(NSArray**)arguments;
- (BOOL)inspectPredicate:(id)predicate code:(NSMutableString*)code arguments:(NSMutableArray*)arguments;
- (BOOL)inspectExpression:(NSExpression*)expression code:(NSMutableString*)code arguments:(NSMutableArray*)arguments;

@end
