//
//  EXMessageRelay.h
//  CRo
//
//  Created by Petr Homola on 10.09.08.
//  Copyright 2008 Univerzita Karlova. All rights reserved.
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
