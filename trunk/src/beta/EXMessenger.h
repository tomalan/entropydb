//
//  EXMessanger.h
//  CRo
//
//  Created by Petr Homola on 10.09.08.
//  Copyright 2008 Univerzita Karlova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXPersistentMessage.h"
#import "EXContainer.h"

@interface EXMessenger : NSObject {
	EXContainer* container;
	id delegate;
}

- (id)initWithFile:(NSString*)fileName;
- (id)initWithContainer:(EXContainer*)_container;
- (BOOL)postMessage:(EXPersistentMessage*)message;
- (BOOL)postMessage:(EXPersistentMessage*)message storage:(id)storage; // storage is a container or a transaction
- (BOOL)transmitToHost:(NSString*)host port:(unsigned)port;
- (BOOL)receiveFromHost:(NSString*)host port:(unsigned)port owner:(NSString*)owner;
- (void)setDelegate:(id)_delegate;
- (EXContainer*)container;

@end
