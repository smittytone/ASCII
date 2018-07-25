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
    
    // Insert code here to initialize your application
    row0 = [[NSMutableArray alloc] init];
    
    // Naming scheme: pixel_{row}_{col}
    [row0 addObject:pixel_0_0];
    [row0 addObject:pixel_0_1];
    [row0 addObject:pixel_0_2];
    [row0 addObject:pixel_0_3];
    [row0 addObject:pixel_0_4];
    [row0 addObject:pixel_0_5];
    [row0 addObject:pixel_0_6];
    [row0 addObject:pixel_0_7];
    
    [row0 addObject:pixel_1_0];
    [row0 addObject:pixel_1_1];
    [row0 addObject:pixel_1_2];
    [row0 addObject:pixel_1_3];
    [row0 addObject:pixel_1_4];
    [row0 addObject:pixel_1_5];
    [row0 addObject:pixel_1_6];
    [row0 addObject:pixel_1_7];
    
    [row0 addObject:pixel_2_0];
    [row0 addObject:pixel_2_1];
    [row0 addObject:pixel_2_2];
    [row0 addObject:pixel_2_3];
    [row0 addObject:pixel_2_4];
    [row0 addObject:pixel_2_5];
    [row0 addObject:pixel_2_6];
    [row0 addObject:pixel_2_7];
    
    [row0 addObject:pixel_3_0];
    [row0 addObject:pixel_3_1];
    [row0 addObject:pixel_3_2];
    [row0 addObject:pixel_3_3];
    [row0 addObject:pixel_3_4];
    [row0 addObject:pixel_3_5];
    [row0 addObject:pixel_3_6];
    [row0 addObject:pixel_3_7];
    
    [row0 addObject:pixel_4_0];
    [row0 addObject:pixel_4_1];
    [row0 addObject:pixel_4_2];
    [row0 addObject:pixel_4_3];
    [row0 addObject:pixel_4_4];
    [row0 addObject:pixel_4_5];
    [row0 addObject:pixel_4_6];
    [row0 addObject:pixel_4_7];
    
    [row0 addObject:pixel_5_0];
    [row0 addObject:pixel_5_1];
    [row0 addObject:pixel_5_2];
    [row0 addObject:pixel_5_3];
    [row0 addObject:pixel_5_4];
    [row0 addObject:pixel_5_5];
    [row0 addObject:pixel_5_6];
    [row0 addObject:pixel_5_7];
    
    [row0 addObject:pixel_6_0];
    [row0 addObject:pixel_6_1];
    [row0 addObject:pixel_6_2];
    [row0 addObject:pixel_6_3];
    [row0 addObject:pixel_6_4];
    [row0 addObject:pixel_6_5];
    [row0 addObject:pixel_6_6];
    [row0 addObject:pixel_6_7];
    
    [row0 addObject:pixel_7_0];
    [row0 addObject:pixel_7_1];
    [row0 addObject:pixel_7_2];
    [row0 addObject:pixel_7_3];
    [row0 addObject:pixel_7_4];
    [row0 addObject:pixel_7_5];
    [row0 addObject:pixel_7_6];
    [row0 addObject:pixel_7_7];
    
    for (i = 0 ; i < 64 ; i++) {
        aPixel = [row0 objectAtIndex:i];
        //aPixel.colour = i % 2 == 0 ? 2 : 0;
        [aPixel update];
    }

    rowSwitch0.toolTip = @"Click to set row; Shift-Click to clear row";
    rowSwitch1.toolTip = rowSwitch0.toolTip;
    rowSwitch2.toolTip = rowSwitch0.toolTip;
    rowSwitch3.toolTip = rowSwitch0.toolTip;
    rowSwitch4.toolTip = rowSwitch0.toolTip;
    rowSwitch5.toolTip = rowSwitch0.toolTip;
    rowSwitch6.toolTip = rowSwitch0.toolTip;
    rowSwitch7.toolTip = rowSwitch0.toolTip;

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

    NSInteger i;
    Pixel *aPixel;
    
    for (i = 0 ; i < 64 ; i++) {
        aPixel = [row0 objectAtIndex:i];
        aPixel.colour = 1;
        [aPixel update];
    }
}



- (IBAction)clearSet:(id)sender {

    NSInteger i;
    Pixel *aPixel;
    
    for (i = 0 ; i < 64 ; i++) {
        aPixel = [row0 objectAtIndex:i];
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
            aPixel = [row0 objectAtIndex:pixl];
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
        aPixel = [row0 objectAtIndex:i];
        aPixel.colour = _window.shiftSet ? 0 : 1;
        [aPixel update];
    }
}



- (IBAction)clearCol:(id)sender {

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
        aPixel = [row0 objectAtIndex:i];
        aPixel.colour = _window.shiftSet ? 0 : 1;
        [aPixel update];
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
                aPixel = [row0 objectAtIndex:((line * 8) + j)];
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



- (IBAction)inverse:(id)sender {

    Pixel *aPixel;
    NSInteger row, col, pixl;
    
    for (row = 0 ; row < 8 ; row++) {
        for (col = 0 ; col < 8 ; col++) {
            pixl = (row * 8) + col;
            aPixel = [row0 objectAtIndex:pixl];
            aPixel.colour = aPixel.colour == 1 ? 0 : 1;
            [aPixel update];
        }
    }
}


- (IBAction)rotate:(id)sender {

    Pixel *aPixel;
    NSInteger row, col, pixl;
    NSInteger ma[8][8];

    // Get the matrix values
    for (row = 0 ; row < 8 ; row++) {
        for (col = 0 ; col < 8 ; col++) {
            pixl = (row * 8) + col;
            aPixel = [row0 objectAtIndex:pixl];
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
            pixl = (row * 8) + col;
            if (pixl < 64) {
                aPixel = [row0 objectAtIndex:pixl];

                NSInteger temp = ma[row][col];
                aPixel.colour = temp;
                [aPixel update];
            }
        }
    }
}



@end
