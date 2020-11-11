
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-20 Tony Smith. All rights reserved.


#import "AppDelegate.h"


@implementation AppDelegate



#pragma mark - Application Lifecycle Methods


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSInteger i;
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
    for (i = 0 ; i < 64 ; i++) {
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
    colourSwitch.state = NSControlStateValueOff;
    redButton.enabled = NO;
    yellowButton.enabled = NO;
    greenButton.enabled = NO;
    inkColour = kColourBlack;
}



- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApp
{
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
        aPixel.colour = inkColour;
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
        aPixel.colour = _window.shiftSet ? 0 : inkColour;
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
        aPixel.colour = _window.shiftSet ? 0 : inkColour;
        [aPixel update];
    }
}



- (IBAction)inverse:(id)sender {

    // Run through all the pixels and set the white ones black
    // and the black ones white

    // Can't inverse colours
    if (colourSwitch.state == NSControlStateValueOn) return;

    Pixel *aPixel = nil;

    for (NSUInteger row = 0 ; row < 8 ; row++) {
        for (NSUInteger col = 0 ; col < 8 ; col++) {
            NSUInteger index = (row * 8) + col;
            aPixel = [pixels objectAtIndex:index];
            aPixel.colour = aPixel.colour == 1 ? 0 : inkColour;
            [aPixel update];
        }
    }
}



- (IBAction)rotate:(id)sender {

    // Rotate all the pixels 90 degrees clockwise
    Pixel *aPixel = nil;
    NSUInteger index;
    NSUInteger ma[8][8];

    // Get the matrix values
    for (NSUInteger row = 0 ; row < 8 ; row++) {
        for (NSUInteger col = 0 ; col < 8 ; col++) {
            index = (row * 8) + col;
            aPixel = [pixels objectAtIndex:index];
            ma[row][col] = aPixel.colour;
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
            index = (row * 8) + col;
            if (index < 64) {
                aPixel = [pixels objectAtIndex:index];
                NSInteger temp = ma[row][col];
                aPixel.colour = temp;
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
            store[(row * 8) + (7 - col)] = aPixel.colour;
        }
    }

    // Write the data back to the grid
    for (NSInteger i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.colour = store[i];
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
            store[((7 - row) * 8) + col] = aPixel.colour;
        }
    }

    // Write the data back to the grid
    for (NSInteger i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.colour = store[i];
        [aPixel update];
    }
}



#pragma mark - Colour Manipulation Methods

- (IBAction)flipColourSwitch:(id)sender {

    // The user has enabled or disable colour mode

    Pixel *aPixel = nil;

    // Is the mode enabled? Record state in 'inColourMode'
    bool inColourMode = colourSwitch.state == NSControlStateValueOn;

    // Enable or disable the radio buttons accordingly
    redButton.enabled = inColourMode;
    yellowButton.enabled = inColourMode;
    greenButton.enabled = inColourMode;

    // Select the ink colour
    if (inColourMode) {
        if (greenButton.state == NSControlStateValueOn) inkColour = kColourGreen;
        if (redButton.state == NSControlStateValueOn) inkColour = kColourRed;
        if (yellowButton.state == NSControlStateValueOn) inkColour = kColourYellow;
    } else {
        inkColour = 0x04;
    }

    // Flip all the pixels from mono to colour, or vice versa
    // NOTE Pixel colours are 3-bit binary values:
    //      b100 is always black, b000 is always white,
    //      b001 = green, b010 = red, b011 = orange
    //      This way we can switch modes without losing colour info
    for (NSInteger row = 0 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            aPixel = [pixels objectAtIndex:((row * 8) + col)];
            if (aPixel.colour != 0) {
                if (inColourMode) {
                    // Unset the 'is black' bit
                    aPixel.colour = aPixel.colour & 0x03;

                    // If the pixel is now white, set it to the current colour,
                    // ie. black -> red, not black -> white
                    if (aPixel.colour == 0) aPixel.colour = inkColour;
                } else {
                    // Just set the 'is black' bit to preserve the colour
                    // info in bits 0 and  1
                    aPixel.colour =  aPixel.colour | 0x04;
                }

                // Set the new target colour - what we will paint - and update
                aPixel.targetColour = inkColour;
                [aPixel setNeedsDisplay:YES];
            }
        }
    }
}


- (IBAction)setColour:(id)sender {

    // Triggered when the user selects on the the colour radio buttons
    // NOTE These are only enabled in Colour mode

    Pixel *aPixel = nil;

    // Set the ink colour according to the selection
    if (sender == greenButton) inkColour = kColourGreen;
    if (sender == redButton) inkColour = kColourRed;
    if (sender == yellowButton) inkColour = kColourYellow;

    // Set every pixel's target colour
    for (NSInteger row = 0 ; row < 8 ; row++) {
        for (NSInteger col = 0 ; col < 8 ; col++) {
            aPixel = [pixels objectAtIndex:((row * 8) + col)];
            aPixel.targetColour = inkColour;
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
        NSUInteger byteValue = 0;
        NSUInteger byteValue2 = 0;

        for (NSUInteger row = 0 ; row < 8 ; row++) {
            NSUInteger index = (row * 8) + col;
            aPixel = [pixels objectAtIndex: index];

            if (inColourMode) {
                // Two bytes per column
                NSUInteger colour = aPixel.colour & 0x03;
                if ((colour & 0x02) != 0) byteValue += (int)(pow(2, (8 - (row + 1))));
                if ((colour & 0x01) != 0) byteValue2 += (int)(pow(2, (8 - (row + 1))));
            } else {
                // Mono mode: just assume any colour value is not zero
                if (aPixel.colour != 0x00) byteValue += (int)(pow(2, (8 - (row + 1))));
            }
        }


        theHex = [theHex stringByAppendingString:[NSString stringWithFormat:formatString, (unsigned long)byteValue]];
        if (inColourMode) theHex = [theHex stringByAppendingString:[NSString stringWithFormat:formatString, (unsigned long)byteValue2]];

        if (!outputToString && col < 7) theHex = [theHex stringByAppendingString:@","];
    }

    if (!outputToString) theHex = [NSString stringWithFormat:@"[%@]", theHex];

    [hexField setStringValue:theHex];
}



- (IBAction)retroFill:(id)sender {

    NSUInteger line, cursor;
    unsigned int value, a;
    NSString *string, *substring;
    NSRange range;
    NSScanner *scanner;
    Pixel *aPixel = nil;

    line = 0;
    cursor = 0;

    [self clearSet:nil];

    string = [hexField stringValue];

    if (!outputToString)
    {
        string = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    }
    else
    {
        string = [string stringByReplacingOccurrencesOfString:@"\\x" withString:@""];
    }

    string = [string stringByReplacingOccurrencesOfString:@"," withString:@""];

    for (NSUInteger i = 0 ; i < string.length - 1 ; i += 2) {
        if (i < 16) {
            // Make sure we only use the first eight pairs of digits
            range = NSMakeRange(i, 2);
            substring = [string substringWithRange:range];
            scanner = [NSScanner scannerWithString:substring];
            [scanner scanHexInt:&value];

            for (NSUInteger j = 0 ; j < 8 ; j++) {
                aPixel = [pixels objectAtIndex:((j * 8) + line)];
                a = value & (int)(pow(2, (7 - j)));
                if (a > 0) aPixel.colour = inkColour;
                value -= a;
                [aPixel update];
            }

            line++;
        } else {
            // TODO Post warning?
            break;
        }
    }
}



@end
