//
//  EXMessageRelay.h
//  Entropy
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (as of version 1.1)
//

#import <Foundation/Foundation.h>
#import "EXContainer.h"

@interface EXMessageRelay : NSObject {
	EXContainer* container;
}

+ (id)relay;
- (void)run;
- (void)runInThread;

@end
