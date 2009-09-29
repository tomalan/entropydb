//
//  XSPredicateInspector.h
//  XSHelper.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>

@interface XSPredicateInspector : NSObject {

}

+ (NSString*)inspectPredicate:(NSPredicate*)predicate arguments:(NSArray**)arguments;
- (BOOL)inspectPredicate:(id)predicate code:(NSMutableString*)code arguments:(NSMutableArray*)arguments;
- (BOOL)inspectExpression:(NSExpression*)expression code:(NSMutableString*)code arguments:(NSMutableArray*)arguments;

@end
