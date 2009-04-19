//
//  EXMessage.h
//  CRo
//
//  Created by Petr Homola on 10.09.08.
//  Copyright 2008 Univerzita Karlova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPersistentMessage : NSObject {
	id from;
	id to;
	id content;
	NSDate* posted;
	NSDate* sent;
	NSDate* delivered;
}

- (id)initWithFrom:(id)_from to:(id)_to content:(id)_content;
- (void)setPosted:(NSDate*)date;
- (void)setSent:(NSDate*)date;
- (void)setDelivered:(NSDate*)date;
- (id)content;
- (id)from;
- (id)to;
- (void)setTo:(id)_to;

@end
