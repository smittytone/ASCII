


#import "Pixel.h"

@implementation Pixel

@synthesize colour;



- (id)initWithFrame:(NSRect)frame {

    self = [super initWithFrame:frame];
    if (self) colour = false;
    return self;
}



- (void)drawRect:(NSRect)rect {

    NSColor *frameColor = colour == 1 ? [NSColor blackColor] : [NSColor whiteColor];
    NSBezierPath *thePath = [NSBezierPath bezierPathWithRect:rect];
    thePath.lineWidth = 0.5;
    [frameColor setFill];
    [thePath fill];
    [[NSColor grayColor] setStroke];
    [thePath stroke];
}



- (void)mouseUp:(NSEvent *)event {

    colour = colour == 1 ? 0 : 1;
    [self setNeedsDisplay:YES];
}


- (void)update {

    [self setNeedsDisplay:YES];
}



@end
