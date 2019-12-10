//
//  AppDelegate.m
//  ASCII
//
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-18 Tony Smith. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

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
}



- (IBAction)fillSet:(id)sender {

    // Run through all the pixels and set them to black
    NSInteger i;
    Pixel *aPixel;

    for (i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.colour = 1;
        [aPixel update];
    }
}



- (IBAction)clearSet:(id)sender {

    // Run through all the pixels and set them to white
    NSInteger i;
    Pixel *aPixel;

    for (i = 0 ; i < 64 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.colour = 0;
        [aPixel update];
    }
}



- (IBAction)calcHex:(id)sender {

    NSString *theHex;
    Pixel *aPixel;
    NSInteger row, col, pixl, a;

    for (row = 0 ; row < 8 ; row++) {
        a = 0;

        for (col = 0 ; col < 8 ; col++) {
            pixl = (row * 8) + col;
            aPixel = [pixels objectAtIndex:pixl];
            if (aPixel.colour == 1) a = a + (int)(pow(2, (8 - (col + 1))));
        }

        if (row == 0) {
            theHex = [NSString stringWithFormat:@"[0x%lX,", (unsigned long)a];
        } else if (row == 7) {
            theHex = [theHex stringByAppendingString:[NSString stringWithFormat:@"0x%lX]", (unsigned long)a]];
        } else {
            theHex = [theHex stringByAppendingString:[NSString stringWithFormat:@"0x%lX,", (unsigned long)a]];
        }
    }

    [hexField setStringValue:theHex];
}


- (IBAction)clearRow:(id)sender {

    // Run through all the pixels in the selected row
    // and colour them white or black
    NSInteger i;
    NSInteger row = 0;
    Pixel *aPixel;

    if (sender == rowSwitch0) row = 0;
    if (sender == rowSwitch1) row = 1;
    if (sender == rowSwitch2) row = 2;
    if (sender == rowSwitch3) row = 3;
    if (sender == rowSwitch4) row = 4;
    if (sender == rowSwitch5) row = 5;
    if (sender == rowSwitch6) row = 6;
    if (sender == rowSwitch7) row = 7;

    row = row * 8;

    for (i = row ; i < row + 8 ; i++) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.colour = _window.shiftSet ? 0 : 1;
        [aPixel update];
    }
}



- (IBAction)clearCol:(id)sender {

    // Run through all the pixels in the selected column
    // and colour them white or black
    NSInteger i;
    NSInteger row = 0;
    Pixel *aPixel;

    if (sender == colSwitch0) row = 0;
    if (sender == colSwitch1) row = 1;
    if (sender == colSwitch2) row = 2;
    if (sender == colSwitch3) row = 3;
    if (sender == colSwitch4) row = 4;
    if (sender == colSwitch5) row = 5;
    if (sender == colSwitch6) row = 6;
    if (sender == colSwitch7) row = 7;

    for (i = row ; i < 64 ; i += 8) {
        aPixel = [pixels objectAtIndex:i];
        aPixel.colour = _window.shiftSet ? 0 : 1;
        [aPixel update];
    }
}



- (IBAction)inverse:(id)sender {

    // Run through all the pixels and set the white ones black
    // and the black ones white
    Pixel *aPixel;
    NSInteger row, col, index;

    for (row = 0 ; row < 8 ; row++) {
        for (col = 0 ; col < 8 ; col++) {
            index = (row * 8) + col;
            aPixel = [pixels objectAtIndex:index];
            aPixel.colour = aPixel.colour == 1 ? 0 : 1;
            [aPixel update];
        }
    }
}



- (IBAction)retroFill:(id)sender {

    NSInteger i, j, line, cursor;
    unsigned int value, a;
    NSString *string, *subString;
    unichar aChar;
    NSRange range;
    NSScanner *scanner;
    Pixel *aPixel;

    line = 0;
    cursor = 0;

    [self clearSet:nil];

    string = [hexField stringValue];
    string = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"]" withString:@""];
    string = [string stringByAppendingString:@","];

    for (i = 0 ; i < string.length ; i++) {
        aChar = [string characterAtIndex:(NSUInteger)i];

        if (aChar == 44) {
            range = NSMakeRange(cursor, 4);
            subString = [string substringWithRange:range];
            scanner = [NSScanner scannerWithString:subString];
            [scanner scanHexInt:&value];

            for (j = 0 ; j < 8 ; j++) {
                aPixel = [pixels objectAtIndex:((line * 8) + j)];
                a = value & (int)(pow(2, (7 - j)));
                if (a > 0) aPixel.colour = 1;
                value = value - a;
                [aPixel update];
            }

            line++;
            cursor = i + 1;
        }
    }
}



- (IBAction)rotate:(id)sender {

    // Rotate all the pixels 90 degrees clockwise
    Pixel *aPixel;
    NSInteger row, col, index;
    NSInteger ma[8][8];

    // Get the matrix values
    for (row = 0 ; row < 8 ; row++) {
        for (col = 0 ; col < 8 ; col++) {
            index = (row * 8) + col;
            aPixel = [pixels objectAtIndex:index];
            ma[row][col] = aPixel.colour;
        }
    }

    // Rotate the matrix 90 degress clockwise
    for (row = 0 ; row <= 7 / 2 ; row++) {
        for (col = row; col < 7 - row; col++) {
            NSInteger temp = ma[row][col];
            ma[row][col] = ma[7 - col][row];
            ma[7 - col][row] = ma[7 - row][7 - col];
            ma[7 - row][7 - col] = ma[col][7 - row];
            ma[col][7 - row] = temp;
        }
    }

    // Write back the rotated matrix
    for (row = 0 ; row < 8 ; row++) {
        for (col = 0 ; col < 8 ; col++) {
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



@end
