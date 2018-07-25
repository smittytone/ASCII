//
//  Pixel.h
//  ASCII
//
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-18 Tony Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Pixel : NSView

- (void)update;

@property (readwrite, assign) NSInteger colour;

@end
