//
//  EXObjectStore.m
//  Linq
//
//  Created by Petr Homola on 28.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EXObjectStore.h"
#import "EXFile.h"

@implementation EXObjectStore

- (id)initWithPath:(NSString*)path {
	if ((self = [super initWithFile: [EXFile fileWithName: path]])) {
		
	}
	return self;
}

- (NSArray*)objectsOfClass:(Class)cls {
	return [super queryWithClass: cls];
}

- (NSArray*)objectsOfClass:(Class)cls predicate:(EXPredicate*)predicate {
	return [super queryWithClass: cls predicate: predicate];
}

@end
