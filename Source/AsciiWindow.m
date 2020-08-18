
//  Created by Tony Smith on 10/02/2014.
//  Copyright (c) 2014-20 Tony Smith. All rights reserved.


#import "AsciiWindow.h"


@implementation AsciiWindow

@synthesize shiftSet;


- (void)flagsChanged:(NSEvent *)theEvent {

    // Remember if the Shift key is currently held down
    // 'shiftSet' is true (Shift key held) or false (Shift key released).
    // The delegate will read this property to check for unpainting pixels
    NSUInteger eventFlags = [theEvent modifierFlags];
    shiftSet = eventFlags & NSEventModifierFlagShift ? YES : NO;
}


@end
