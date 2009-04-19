//
//  EXDrainer.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under GPLv3
//

#import <Foundation/Foundation.h>

@class EXContainer;

@interface EXDrainer : NSObject {
	EXContainer* container;
	BOOL active;
	BOOL autoreleased;
}

- (id)initWithContainer:(EXContainer*)_container;
- (void)deactivate;
- (BOOL)isAutoreleased;

@end
