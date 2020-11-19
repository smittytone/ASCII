
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-20 Tony Smith. All rights reserved.


#import <Cocoa/Cocoa.h>
#import "Constants.h"


@interface Pixel : NSView
{
    BOOL mouseDown;
    NSNotificationCenter *nc;
    NSInteger storeColour;
}


- (void)update;
- (void)passedMouseDown:(NSNotification *)note;
- (void)passedMouseUp:(NSNotification *)note;


@property (readwrite, assign) NSInteger pixelColour;
@property (readwrite, assign) NSInteger drawColour;


@end
