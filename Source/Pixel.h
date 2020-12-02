/*
    Pixel.h
    ASCII

    Copyright © 2020 Tony Smith. All rights reserved.

    MIT License
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
 */


#import <Cocoa/Cocoa.h>
#import "Constants.h"


/*
    Class representing a pixel view.
 
    It records the pixel's current colour ('pixelColour') and the ink colour ('drawColour').
    It also manages mouse clicks, releases and drags to enable painting across pixel boundaries.
 */

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
