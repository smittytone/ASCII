/*
    AppDelegate.m
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

#import "AppDelegate.h"


@implementation AppDelegate



#pragma mark - Application Lifecycle Methods


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    Pixel *aPixel;

    // Set up the array that will hold all the pixel views
    pixels = [[NSMutableArray alloc] init];

    // Add the pixel views to the array
    // Naming scheme: pixel_{row}_{col}
    [pixels addObject:pixel_0_0];
    [pixels addObject:pixel_0_1];
    [pixels addObject:pixel_0_2];
    [pixels addObject:pixel_0_3];
    [pixels addObject:pixel_0_4];
    [pixels addObject:pixel_0_5];
    [pixels addObject:pixel_0_6];
    [pixels addObject:pixel_0_7];

    [pixels addObject:pixel_1_0];
    [pixels addObject:pixel_1_1];
    [pixels addObject:pixel_1_2];
    [pixels addObject:pixel_1_3];
    [pixels addObject:pixel_1_4];
    [pixels addObject:pixel_1_5];
    [pixels addObject:pixel_1_6];
    [pixels addObject:pixel_1_7];

    [pixels addObject:pixel_2_0];
    [pixels addObject:pixel_2_1];
    [pixels addObject:pixel_2_2];
    [pixels addObject:pixel_2_3];
    [pixels addObject:pixel_2_4];
    [pixels addObject:pixel_2_5];
    [pixels addObject:pixel_2_6];
    [pixels addObject:pixel_2_7];

    [pixels addObject:pixel_3_0];
    [pixels addObject:pixel_3_1];
    [pixels addObject:pixel_3_2];
    [pixels addObject:pixel_3_3];
    [pixels addObject:pixel_3_4];
    [pixels addObject:pixel_3_5];
    [pixels addObject:pixel_3_6];
    [pixels addObject:pixel_3_7];

    [pixels addObject:pixel_4_0];
    [pixels addObject:pixel_4_1];
    [pixels addObject:pixel_4_2];
    [pixels addObject:pixel_4_3];
    [pixels addObject:pixel_4_4];
    [pixels addObject:pixel_4_5];
    [pixels addObject:pixel_4_6];
    [pixels addObject:pixel_4_7];

    [pixels addObject:pixel_5_0];
    [pixels addObject:pixel_5_1];
    [pixels addObject:pixel_5_2];
    [pixels addObject:pixel_5_3];
    [pixels addObject:pixel_5_4];
    [pixels addObject:pixel_5_5];
    [pixels addObject:pixel_5_6];
    [pixels addObject:pixel_5_7];

    [pixels addObject:pixel_6_0];
    [pixels addObject:pixel_6_1];
    [pixels addObject:pixel_6_2];
    [pixels addObject:pixel_6_3];
    [pixels addObject:pixel_6_4];
    [pixels addObject:pixel_6_5];
    [pixels addObject:pixel_6_6];
    [pixels addObject:pixel_6_7];

    [pixels addObject:pixel_7_0];
    [pixels addObject:pixel_7_1];
    [pixels addObject:pixel_7_2];
    [pixels addObject:pixel_7_3];
    [pixels addObject:pixel_7_4];
    [pixels addObject:pixel_7_5];
    [pixels addObject:pixel_7_6];
    [pixels addObject:pixel_7_7];

    // Trigger a pixel redraw
    // NOTE May be unnecessary
    for (NSUInteger i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        [aPixel update];
    }

    // Set the row fill buttons' tooltips
    rowSwitch0.toolTip = @"Click to set row; Shift-Click to clear row";
    rowSwitch1.toolTip = rowSwitch0.toolTip;
    rowSwitch2.toolTip = rowSwitch0.toolTip;
    rowSwitch3.toolTip = rowSwitch0.toolTip;
    rowSwitch4.toolTip = rowSwitch0.toolTip;
    rowSwitch5.toolTip = rowSwitch0.toolTip;
    rowSwitch6.toolTip = rowSwitch0.toolTip;
    rowSwitch7.toolTip = rowSwitch0.toolTip;

    // Set the column fill buttons' tooltips
    colSwitch0.toolTip = @"Click to set column; Shift-Click to clear column";
    colSwitch1.toolTip = colSwitch0.toolTip;
    colSwitch2.toolTip = colSwitch0.toolTip;
    colSwitch3.toolTip = colSwitch0.toolTip;
    colSwitch4.toolTip = colSwitch0.toolTip;
    colSwitch5.toolTip = colSwitch0.toolTip;
    colSwitch6.toolTip = colSwitch0.toolTip;
    colSwitch7.toolTip = rowSwitch0.toolTip;

    // FROM 1.2.0
    // Set the value readout type
    outputToString = true;

    // FROM 1.3.0
    // Support three-colour LEDs
    colourSwitch.state = NSControlStateValueOff;
    redButton.enabled = NO;
    yellowButton.enabled = NO;
    greenButton.enabled = NO;
    greenColourMenuItem.enabled = NO;
    redColourMenuItem.enabled = NO;
    yellowColourMenuItem.enabled = NO;
    inkColour = kColourBlack;

    // Centre the window and show it
    [_window center];
    [_window makeKeyAndOrderFront:self];
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApp {

    // Return YES to quit app when user clicks on the close button

    return YES;
}


#pragma mark - Pixel Grid Manipulation Methods

- (IBAction)fillSet:(id)sender {

    // Run through all the pixels and set them to black

    [self paintAllPixels:inkColour];
}


- (IBAction)clearSet:(id)sender {

    // Run through all the pixels and set them to white

    [self paintAllPixels:kColourWhite];
}


- (void)paintAllPixels:(NSUInteger)color {

    // Generic all-pixel filler

    Pixel *aPixel = nil;
    
    for (NSUInteger i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.pixelColour = color;
        [aPixel update];
    }
}


- (IBAction)clearRow:(id)sender {

    // Run through all the pixels in the selected row
    // and colour them white or black

    NSUInteger row = 0;
    Pixel *aPixel = nil;

    if (sender == rowSwitch0) row = 0;
    if (sender == rowSwitch1) row = 1;
    if (sender == rowSwitch2) row = 2;
    if (sender == rowSwitch3) row = 3;
    if (sender == rowSwitch4) row = 4;
    if (sender == rowSwitch5) row = 5;
    if (sender == rowSwitch6) row = 6;
    if (sender == rowSwitch7) row = 7;

    row *= 8;

    for (NSUInteger i = row ; i < row + 8 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.pixelColour = _window.shiftSet ? 0 : inkColour;
        [aPixel update];
    }
}


- (IBAction)clearCol:(id)sender {

    // Run through all the pixels in the selected column
    // and colour them white or black
    NSUInteger col = 0;
    Pixel *aPixel = nil;

    if (sender == colSwitch0) col = 0;
    if (sender == colSwitch1) col = 1;
    if (sender == colSwitch2) col = 2;
    if (sender == colSwitch3) col = 3;
    if (sender == colSwitch4) col = 4;
    if (sender == colSwitch5) col = 5;
    if (sender == colSwitch6) col = 6;
    if (sender == colSwitch7) col = 7;

    for (NSUInteger i = col ; i < 64 ; i += 8) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.pixelColour = _window.shiftSet ? 0 : inkColour;
        [aPixel update];
    }
}


- (IBAction)inverse:(id)sender {

    // Run through all the pixels and set the white ones black
    // and the black ones white

    Pixel *aPixel = nil;

    for (NSUInteger row = 0 ; row < 8 ; row++) {
        for (NSUInteger col = 0 ; col < 8 ; col++) {
            NSUInteger index = (row * 8) + col;
            aPixel = [pixels objectAtIndex:index];
            aPixel.pixelColour = aPixel.pixelColour != kColourWhite ? kColourWhite : inkColour;
            [aPixel update];
        }
    }
}


- (IBAction)rotate:(id)sender {

    // Rotate all the pixels 90 degrees clockwise
    
    Pixel *aPixel = nil;
    NSUInteger ma[8][8];

    // Get the matrix values
    for (NSUInteger row = 0 ; row < 8 ; row++) {
        for (NSUInteger col = 0 ; col < 8 ; col++) {
            NSUInteger index = (row * 8) + col;
            aPixel = [pixels objectAtIndex:index];
            ma[row][col] = aPixel.pixelColour;
        }
    }

    // Rotate the matrix 90 degress clockwise
    for (NSUInteger row = 0 ; row <= 7 / 2 ; row++) {
        for (NSUInteger col = row; col < 7 - row; col++) {
            NSInteger temp = ma[row][col];
            ma[row][col] = ma[7 - col][row];
            ma[7 - col][row] = ma[7 - row][7 - col];
            ma[7 - row][7 - col] = ma[col][7 - row];
            ma[col][7 - row] = temp;
        }
    }

    // Write back the rotated matrix
    for (NSUInteger row = 0 ; row < 8 ; row++) {
        for (NSUInteger col = 0 ; col < 8 ; col++) {
            NSUInteger index = (row * 8) + col;
            if (index < 64) {
                aPixel = [pixels objectAtIndex:index];
                NSInteger temp = ma[row][col];
                aPixel.pixelColour = temp;
                [aPixel update];
            }
        }
    }
}


- (IBAction)flipHorizontal:(id)sender {

    Pixel *aPixel = nil;
    NSInteger store[64];

    // Write the grid values to a temporary store, converting
    // the co-ordinates as we go
    for (NSInteger row = 0 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            aPixel = [pixels objectAtIndex:((row * 8) + col)];
            store[(row * 8) + (7 - col)] = aPixel.pixelColour;
        }
    }

    // Write the data back to the grid
    for (NSInteger i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.pixelColour = store[i];
        [aPixel update];
    }
}


- (IBAction)flipVertical:(id)sender {

    Pixel *aPixel = nil;
    NSInteger store[64];

    // Write the grid values to a temporary store, converting
    // the co-ordinates as we go
    for (NSInteger row = 0 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            aPixel = [pixels objectAtIndex:((row * 8) + col)];
            store[((7 - row) * 8) + col] = aPixel.pixelColour;
        }
    }

    // Write the data back to the grid
    for (NSInteger i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.pixelColour = store[i];
        [aPixel update];
    }
}


- (IBAction)shiftLeft:(id)sender {
    
    // Move all the pixels left one column
    Pixel *destPixel = nil;
    Pixel *srcPixel = nil;
    
    for (NSInteger col = 1 ; col < 8 ; col++) {
        for (NSInteger row = 0 ; row < 8 ; row++) {
            srcPixel = [pixels objectAtIndex:((row << 3) + col)];
            destPixel = [pixels objectAtIndex:((row << 3) + col - 1)];
            destPixel.pixelColour = srcPixel.pixelColour;
            if (col == 7) srcPixel.pixelColour = kColourWhite;
        }
    }
    
    [self updateAll];
}


- (IBAction)shiftRight:(id)sender {
    
    // Move all the pixels right one column
    Pixel *destPixel = nil;
    Pixel *srcPixel = nil;
    
    for (NSInteger col = 7 ; col > 0 ; col--) {
        for (NSInteger row = 0 ; row < 8 ; row++) {
            destPixel = [pixels objectAtIndex:((row << 3) + col)];
            srcPixel = [pixels objectAtIndex:((row << 3) + col - 1)];
            destPixel.pixelColour = srcPixel.pixelColour;
            if (col == 1) srcPixel.pixelColour = kColourWhite;
        }
    }
    
    [self updateAll];
}


- (IBAction)shiftUp:(id)sender {
    
    // Move all the pixels up one row
    Pixel *destPixel = nil;
    Pixel *srcPixel = nil;
    
    for (NSInteger row = 1 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            destPixel = [pixels objectAtIndex:(((row - 1) << 3) + col)];
            srcPixel = [pixels objectAtIndex:((row << 3) + col)];
            destPixel.pixelColour = srcPixel.pixelColour;
            if (row == 7) srcPixel.pixelColour = kColourWhite;
        }
    }
    
    [self updateAll];
}


- (IBAction)shiftDown:(id)sender {
    
    // Move all the pixels down one row
    Pixel *destPixel = nil;
    Pixel *srcPixel = nil;
    
    for (NSInteger row = 7 ; row > 0 ; row--) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            srcPixel = [pixels objectAtIndex:(((row - 1) << 3) + col)];
            destPixel = [pixels objectAtIndex:((row << 3) + col)];
            destPixel.pixelColour = srcPixel.pixelColour;
            if (row == 1) srcPixel.pixelColour = kColourWhite;
        }
    }
    
    [self updateAll];
}


- (void)updateAll {
    
    for (NSInteger i = 0 ; i < 64 ; i++) {
        [[pixels objectAtIndex:i] update];
    }
}


#pragma mark - Colour Manipulation Methods

- (IBAction)flipColourSwitch:(id)sender {

    // The user has enabled or disable colour mode

    Pixel *aPixel = nil;

    if (sender == colourSwitchMenuItem) {
        colourSwitch.state = !colourSwitch.state;
    }

    // Is the mode enabled? Record state in 'inColourMode'
    bool inColourMode = colourSwitch.state == NSControlStateValueOn;

    // Enable or disable the radio buttons accordingly
    redButton.enabled = inColourMode;
    yellowButton.enabled = inColourMode;
    greenButton.enabled = inColourMode;

    // Handle the paint colour menu items
    greenColourMenuItem.enabled = inColourMode;
    redColourMenuItem.enabled = inColourMode;
    yellowColourMenuItem.enabled = inColourMode;

    // Handle the invert controls
    inverseButton.enabled = !inColourMode;
    inverseMenuItem.enabled = !inColourMode;

    // Select the ink colour and the menu state
    if (inColourMode) {
        if (greenButton.state == NSControlStateValueOn) inkColour = kColourGreen;
        if (redButton.state == NSControlStateValueOn) inkColour = kColourRed;
        if (yellowButton.state == NSControlStateValueOn) inkColour = kColourYellow;
        colourSwitchMenuItem.title = @"Switch to Mono Mode";
    } else {
        inkColour = kColourBlack;
        colourSwitchMenuItem.title = @"Switch to Colour Mode";
    }

    // Flip all the pixels from mono to colour, or vice versa
    // NOTE Pixel colours are 3-bit binary values:
    //      b100 is always black, b000 is always white,
    //      b001 = green, b010 = red, b011 = orange
    //      This way we can switch modes without losing colour info
    for (NSInteger row = 0 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            aPixel = [pixels objectAtIndex:((row * 8) + col)];
            if (aPixel.pixelColour != 0) {
                if (inColourMode) {
                    // Unset the 'is black' bit
                    aPixel.pixelColour = aPixel.pixelColour & 0x03;

                    // If the pixel is now white, set it to the current colour,
                    // ie. black -> red, not black -> white
                    if (aPixel.pixelColour == 0) aPixel.pixelColour = inkColour;
                } else {
                    // Just set the 'is black' bit to preserve the colour
                    // info in bits 0 and  1
                    aPixel.pixelColour =  aPixel.pixelColour | 0x04;
                }

                // Update the pixel
                [aPixel setNeedsDisplay:YES];
            }

            // Set the new target colour - what we will paint
            aPixel.drawColour = inkColour;
        }
    }
}


- (IBAction)setColour:(id)sender {

    // Triggered when the user selects on the the colour radio buttons
    // NOTE These are only enabled in Colour mode

    // Set the ink colour according to the selection
    if (sender == greenButton) inkColour = kColourGreen;
    if (sender == redButton) inkColour = kColourRed;
    if (sender == yellowButton) inkColour = kColourYellow;

    if (sender == greenColourMenuItem) {
        inkColour = kColourGreen;
        greenButton.state = NSControlStateValueOn;
    }

    if (sender == redColourMenuItem) {
        inkColour = kColourRed;
        redButton.state = NSControlStateValueOn;
    }

    if (sender == yellowColourMenuItem) {
        inkColour = kColourYellow;
        yellowButton.state = NSControlStateValueOn;
    }

    // Set every pixel's target colour
    [self setPixelDrawColour:inkColour];

    [self setPaintColourMenuStates:inkColour];
}


- (void)setPaintColourMenuStates:(NSUInteger)colour {

    // Set and unset Paint Colour sub-menu items' state according to 'colour'
    bool state1 = ((colour & 1) > 0);
    bool state2 = ((colour & 2) > 0);

    greenColourMenuItem.state = !state1 && state2 ? NSControlStateValueOn : NSControlStateValueOff;
    redColourMenuItem.state = state1 && !state2 ? NSControlStateValueOn : NSControlStateValueOff;
    yellowColourMenuItem.state = state1 && state2 ? NSControlStateValueOn : NSControlStateValueOff;
}


- (void)setPixelDrawColour:(NSUInteger)colour {

    // Set every pixel's target colour

    Pixel *aPixel = nil;
    for (NSInteger row = 0 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            aPixel = [pixels objectAtIndex:((row * 8) + col)];
            aPixel.drawColour = colour;
        }
    }
}


#pragma mark - Grid I/O Methods

- (IBAction)setOutputType:(id)sender
{
    // Set the flag for output type (to hex string or array of hex values)
    // according to the state of the radio controls
    outputToString = (stringButton.state == NSControlStateValueOn);
}


- (IBAction)calcHex:(id)sender {

    // Read the pixel grid and generate eight hex column values
    Pixel *aPixel = nil;
    NSString *theHex = @"";
    NSString *formatString = outputToString ? @"\\x%02X" : @"0x%02X";

    // Is the mode enabled? Record state in 'inColourMode'
    bool inColourMode = colourSwitch.state == NSControlStateValueOn;

    for (NSUInteger col = 0 ; col < 8 ; col++) {
        NSUInteger byteValueLeft = 0;
        NSUInteger byteValueRight = 0;

        for (NSUInteger row = 0 ; row < 8 ; row++) {
            NSUInteger index = (row * 8) + col;
            aPixel = [pixels objectAtIndex: index];

            if (inColourMode) {
                // Two bytes per column
                NSUInteger colour = aPixel.pixelColour & 0x03;
                if ((colour & 0x02) != 0) byteValueLeft += (int)(pow(2, (8 - (row + 1))));
                if ((colour & 0x01) != 0) byteValueRight += (int)(pow(2, (8 - (row + 1))));
            } else {
                // Mono mode: just assume any colour value is not zero
                if (aPixel.pixelColour != 0x00) byteValueLeft += (int)(pow(2, (8 - (row + 1))));
            }
        }

        theHex = [theHex stringByAppendingString:[NSString stringWithFormat:formatString, (unsigned long)byteValueLeft]];
        if (inColourMode) theHex = [theHex stringByAppendingString:[NSString stringWithFormat:formatString, (unsigned long)byteValueRight]];

        if (!outputToString && col < 7) theHex = [theHex stringByAppendingString:@","];
    }

    if (!outputToString) theHex = [NSString stringWithFormat:@"[%@]", theHex];

    [hexField setStringValue:theHex];
}



- (IBAction)retroFill:(id)sender {

    NSUInteger valueLeft, valueRight, byteLeft, byteRight, row, cursor;
    Pixel *aPixel = nil;

    // Is the mode enabled? Record state in 'inColourMode'
    bool inColourMode = colourSwitch.state == NSControlStateValueOn;

    // Get the entered string, if there is one
    NSString *string = [hexField stringValue];

    // Make sure we have a string to work with
    if (string.length == 0) return;

    // Tidy up the string as best as possible
    if (!outputToString) {
        string = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    } else {
        string = [string stringByReplacingOccurrencesOfString:@"\\x" withString:@""];
    }

    string = [string stringByReplacingOccurrencesOfString:@"," withString:@""];

    // Check the validity of the string
    if (string.length % 2 != 0) {
        [self showError:@"Bad Hex String" :@"Enter a string that contains an even number of hex characters"];
        return;
    }

    // Chomp strings to the expected length
    if (inColourMode && string.length > 32) string = [string substringToIndex:32];
    if (!inColourMode && string.length > 16) string = [string substringToIndex:16];

    // Clear the grid
    [self clearSet:nil];

    // Set the pixels according to the supplied hex values
    row = 0;
    cursor = 0;
    valueLeft = 0;
    valueRight = 0;
    while (cursor < string.length - 1) {
        valueLeft = [self getHexValue:cursor :string];
        if (valueLeft == kHexValueError) return;
        cursor += 2;

        if (inColourMode) {
            valueRight = [self getHexValue:cursor :string];
            if (valueRight == kHexValueError) return;
            cursor += 2;
        }

        for (NSUInteger j = 0 ; j < 8 ; j++) {
            aPixel = [pixels objectAtIndex:((j * 8) + row)];
            byteLeft = valueLeft & (1 << (7 - j));

            if (inColourMode) {
                // Use the bit values not only to determine if a pixel is set (either bit is 1)
                // but the colour of the set pixel:
                // Byte 1 Bit | Byte 2 Bit | Colour
                // -----------+------------+--------
                //     0      |      0     | None
                //     1      |      0     | Green
                //     0      |      1     | Red
                //     1      |      1     | Orange
                byteRight = valueRight & (1 << (7 - j));
                if (byteLeft != 0 | byteRight != 0) aPixel.pixelColour = ((byteLeft >> (7 - j)) << 1) | (byteRight >> (7 - j));
            } else {
                // For a mono display, if the bit is set, the pixel is lit
                if (byteLeft != 0) aPixel.pixelColour = kColourBlack;
            }

            // Fill in the pixel if it is lit
            if (aPixel.pixelColour != kColourWhite) [aPixel update];
        }

        // Check that we're not going to break the loop
        if ( inColourMode && cursor > 28) break;
        if (!inColourMode && cursor > 14) break;

        // Move to the next row
        row++;
    }
}


- (NSUInteger)getHexValue:(NSInteger)index :(NSString *)string {

    // Extracts a two-character substring from the supplied string, at location 'index'
    // and returns the integer value of those hex characters

    unsigned int returnValue;
    NSRange range = NSMakeRange(index, 2);
    NSString *substring = [string substringWithRange:range];
    NSScanner *scanner = [NSScanner scannerWithString:substring];

    // Check if the scanning acutally worked
    bool success = [scanner scanHexInt:&returnValue];

    // It didn't, so show an error and bail
    if (!success) {
        [self showError:@"Bad Hex String" :@"Enter a string that only contains hex characters"];
        return kHexValueError;
    }

    return (NSUInteger)returnValue;
}


#pragma mark - Misc Methods

- (void)showError:(NSString *)title :(NSString *)message {

    // Generic error display routine

    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : title,
                               NSLocalizedRecoverySuggestionErrorKey : message };
    NSError *error = [NSError errorWithDomain:@"ASCII"
                                         code:400
                                     userInfo:userInfo];
    [_window presentError:error];
}


- (IBAction)showOnlineHelp:(id)sender {

    // Open online help

    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"https://smittytone.net/ascii/index.html"]];
}

@end
