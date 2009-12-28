//
//  EXObjectStore.h
//  Linq
//
//  Created by Petr Homola on 28.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EXContainer.h"
#import "EXPredicate.h"

@interface EXObjectStore : EXContainer {
	//
}

- (id)initWithPath:(NSString*)path;
- (NSArray*)objectsOfClass:(Class)cls;
- (NSArray*)objectsOfClass:(Class)cls predicate:(EXPredicate*)predicate;

@end
