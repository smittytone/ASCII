//
//  Pixel.h
//  ASCII
//
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-18 Tony Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Pixel : NSView
{
    BOOL mouseDown;
    NSNotificationCenter *nc;
    NSInteger targetColour;
}


- (void)update;
- (void)passMouseDown:(NSNotification *)note;
- (void)passMouseUp:(NSNotification *)note;


@property (readwrite, assign) NSInteger colour;


@end
