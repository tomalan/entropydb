//
//  XSDecomposer.h
//  test
//
//  Created by Petr Homola on 28.9.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XSEncoder.h"

@interface XSDecomposer : NSObject {

}

- (void)decomposeObject:(id)obj encoder:(XSEncoder*)encoder;

@end