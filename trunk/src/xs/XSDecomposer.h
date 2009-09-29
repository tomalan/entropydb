//
//  XSDecomposer.h
//  XS package (serializer)
//  (C) 2007-2009 Codesign
//  Licensed under LGPL (v3)
//

#import <Cocoa/Cocoa.h>
#import "XSEncoder.h"

@interface XSDecomposer : NSObject {

}

- (void)decomposeObject:(id)obj encoder:(XSEncoder*)encoder;

@end
