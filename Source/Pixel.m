
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-20 Tony Smith. All rights reserved.


#import "Pixel.h"


@implementation Pixel

@synthesize pixelColour, drawColour;



- (id)initWithFrame:(NSRect)frame {

    self = [super initWithFrame:frame];

    if (self) {
        // Initialize the pixel's properties
        pixelColour = 0;
        drawColour = kColourBlack;
        storeColour = kColourBlack;
        mouseDown = NO;

        // Establish a mouse-tracking area...
        NSRect rect = NSMakeRect(0, 0, 32, 32);
        NSTrackingArea *trackArea = [[NSTrackingArea alloc] initWithRect:rect
                                                                 options:NSTrackingMouseEnteredAndExited |
                                                                         NSTrackingActiveInActiveApp |
                                                                         NSTrackingEnabledDuringMouseDrag
                                                                   owner:self
                                                                userInfo:nil];

        // ...and add it to the view
        [self addTrackingArea:trackArea];

        // Set the pixel to watch for event-related messages from other pixels
        nc = NSNotificationCenter.defaultCenter;

        [nc addObserver:self
               selector:@selector(passedMouseDown:)
                   name:@"PixelMouseDown"
                 object:nil];

        [nc addObserver:self
               selector:@selector(passedMouseUp:)
                   name:@"PixelMouseUp"
                 object:nil];

    }

    return self;
}



- (void)drawRect:(NSRect)rect {

    // Fill the pixel with the desired pixelColour and give it a grey frame
    NSColor *frameColor = [self pickColour];
    NSBezierPath *thePath = [NSBezierPath bezierPathWithRect:rect];
    thePath.lineWidth = 0.5;
    [frameColor setFill];
    [thePath fill];
    [[NSColor grayColor] setStroke];
    [thePath stroke];
}



- (void)mouseDown:(NSEvent *)event {

    // Change the clicked pixel's pixelColour
    pixelColour = pixelColour == drawColour ? kColourWhite : drawColour;

    // Paint the clicked pixel
    [self setNeedsDisplay:YES];

    // Tell ALL the pixels that the mouse has been pressed and pass the clicked
    // pixel's colour - this will become ALL pixels' new ink colour
    NSDictionary *dict = @{ @"PixelColour" : [NSNumber numberWithInteger:pixelColour]};
    [nc postNotificationName:@"PixelMouseDown" object:self userInfo:dict];
}



- (void)mouseUp:(NSEvent *)event {

    // Tell ALL the pixels that the mouse has been released
    [nc postNotificationName:@"PixelMouseUp" object:self userInfo:nil];
}



- (void)mouseEntered:(NSEvent *)theEvent {

    // We are trakcing mouse movements across pixel boundaries. If we enter a
    // pixel and 'mouseDown' is true, we need to paint this pixel with the
    // same pixelColour as the first painted pixel
    if (mouseDown) {
        pixelColour = drawColour;
        [self setNeedsDisplay:YES];
    }
}



- (void)passedMouseDown:(NSNotification *)note {

    // A pixel (it might be this one) has signalled a mouse-down event,
    // so if the sender was not this pixel
    if (!mouseDown) {
        mouseDown = YES;

        // Get the source pixel's new colour and this pixel ink 'drawColour' to match
        NSDictionary *dict = (NSDictionary *)note.userInfo;
        NSNumber *num = [dict objectForKey:@"PixelColour"];
        storeColour = drawColour;
        drawColour = num.integerValue;
    }
}



- (void)passedMouseUp:(NSNotification *)note {

    // A pixel (it might be this one) has signalled a mouse-up event,
    // so if the sender was not this pixel, 'mouseDown' will be true
    if (mouseDown) {
        mouseDown = NO;
        drawColour = storeColour;
    }
}



- (void)update {

    // Pixel paint trigger for other classes to trigger
    [self setNeedsDisplay:YES];
}


- (NSColor *)pickColour {

    // Return the appropriate NSColor based on the current pixelColour int value

    switch(pixelColour) {
        case kColourWhite:
            return [NSColor whiteColor];
        case kColourRed:
            return [NSColor redColor];
        case kColourGreen:
            return [NSColor greenColor];
        case kColourYellow:
            return [NSColor orangeColor];
    }

    return [NSColor blackColor];
}

@end
