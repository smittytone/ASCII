


#import "Pixel.h"

@implementation Pixel

@synthesize colour;



- (id)initWithFrame:(NSRect)frame {

    self = [super initWithFrame:frame];

    if (self) {
        // Initialize the pixel's properties
        colour = 0;
        targetColour = 0;
        mouseDown = NO;

        // Establish a mouse-tracking area...
        NSRect rect = NSMakeRect(0, 0, 32, 32);
        NSTrackingArea *trackArea = [[NSTrackingArea alloc] initWithRect:rect
                                                                 options:NSTrackingMouseEnteredAndExited |
                                                                         NSTrackingActiveInActiveApp |
                                                                         NSTrackingEnabledDuringMouseDrag
                                                                   owner:self
                                                                userInfo:nil];

        // ...and add it to the
        [self addTrackingArea:trackArea];

        // Set the pixel to watch for event-related messages from other pixels
        nc = NSNotificationCenter.defaultCenter;

        [nc addObserver:self
               selector:@selector(passMouseDown:)
                   name:@"PixelMouseDown"
                 object:nil];

        [nc addObserver:self
               selector:@selector(passMouseUp:)
                   name:@"PixelMouseUp"
                 object:nil];

    }

    return self;
}



- (void)drawRect:(NSRect)rect {

    // Fill the pixel with the desired colour and give it a grey frame
    NSColor *frameColor = colour == 1 ? [NSColor blackColor] : [NSColor whiteColor];
    NSBezierPath *thePath = [NSBezierPath bezierPathWithRect:rect];
    thePath.lineWidth = 0.5;
    [frameColor setFill];
    [thePath fill];
    [[NSColor grayColor] setStroke];
    [thePath stroke];
}



- (void)mouseUp:(NSEvent *)event {

    // Tell all the other pixels that the mouse has been released
    [nc postNotificationName:@"PixelMouseUp" object:self userInfo:nil];
}



- (void)mouseDown:(NSEvent *)event {

    // Change the pixel's colour
    colour = colour == 1 ? 0 : 1;
    mouseDown = YES;

    // Tell all the other pixels that the mouse has been released
    NSDictionary *dict = @{ @"colour" : [NSNumber numberWithInteger:colour]};
    [nc postNotificationName:@"PixelMouseDown" object:self userInfo:dict];

    // Update the display
    [self setNeedsDisplay:YES];
}



- (void)mouseEntered:(NSEvent *)theEvent {

    // We are trakcing mouse movements across pixel boundaries. If we enter a
    // pixel and 'mouseDown' is true, we need to paint this pixel with the
    // same colour as is the first painted pixel
    if (mouseDown) {
        colour = targetColour;
        [self setNeedsDisplay:YES];
    }
}



- (void)passMouseDown:(NSNotification *)note {

    // A pixel (it might be this one) has signalled a mouse-down event,
    // so if the sender was not this pixel, 'mouseDown' will be false
    if (!mouseDown) {
        mouseDown = YES;

        // Get the source pixel's new colour and record as 'targetColour'
        NSDictionary *dict = (NSDictionary *)note.userInfo;
        NSNumber *num = [dict objectForKey:@"colour"];
        targetColour = num.integerValue;
    }
}



- (void)passMouseUp:(NSNotification *)note {

    // A pixel (it might be this one) has signalled a mouse-up event,
    // so if the sender was not this pixel, 'mouseDown' will be true
    if (mouseDown) mouseDown = NO;
}



- (void)update {

    [self setNeedsDisplay:YES];
}



@end
