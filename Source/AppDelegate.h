/*
    AppDelegate.h
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
#import "Pixel.h"
#import "AsciiWindow.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    // Pixel views in the on-screen grid.
    // Naming scheme: pixel_{row}_{col}
    IBOutlet Pixel *pixel_0_0;
    IBOutlet Pixel *pixel_0_1;
    IBOutlet Pixel *pixel_0_2;
    IBOutlet Pixel *pixel_0_3;
    IBOutlet Pixel *pixel_0_4;
    IBOutlet Pixel *pixel_0_5;
    IBOutlet Pixel *pixel_0_6;
    IBOutlet Pixel *pixel_0_7;

    IBOutlet Pixel *pixel_1_0;
    IBOutlet Pixel *pixel_1_1;
    IBOutlet Pixel *pixel_1_2;
    IBOutlet Pixel *pixel_1_3;
    IBOutlet Pixel *pixel_1_4;
    IBOutlet Pixel *pixel_1_5;
    IBOutlet Pixel *pixel_1_6;
    IBOutlet Pixel *pixel_1_7;

    IBOutlet Pixel *pixel_2_0;
    IBOutlet Pixel *pixel_2_1;
    IBOutlet Pixel *pixel_2_2;
    IBOutlet Pixel *pixel_2_3;
    IBOutlet Pixel *pixel_2_4;
    IBOutlet Pixel *pixel_2_5;
    IBOutlet Pixel *pixel_2_6;
    IBOutlet Pixel *pixel_2_7;

    IBOutlet Pixel *pixel_3_0;
    IBOutlet Pixel *pixel_3_1;
    IBOutlet Pixel *pixel_3_2;
    IBOutlet Pixel *pixel_3_3;
    IBOutlet Pixel *pixel_3_4;
    IBOutlet Pixel *pixel_3_5;
    IBOutlet Pixel *pixel_3_6;
    IBOutlet Pixel *pixel_3_7;

    IBOutlet Pixel *pixel_4_0;
    IBOutlet Pixel *pixel_4_1;
    IBOutlet Pixel *pixel_4_2;
    IBOutlet Pixel *pixel_4_3;
    IBOutlet Pixel *pixel_4_4;
    IBOutlet Pixel *pixel_4_5;
    IBOutlet Pixel *pixel_4_6;
    IBOutlet Pixel *pixel_4_7;

    IBOutlet Pixel *pixel_5_0;
    IBOutlet Pixel *pixel_5_1;
    IBOutlet Pixel *pixel_5_2;
    IBOutlet Pixel *pixel_5_3;
    IBOutlet Pixel *pixel_5_4;
    IBOutlet Pixel *pixel_5_5;
    IBOutlet Pixel *pixel_5_6;
    IBOutlet Pixel *pixel_5_7;

    IBOutlet Pixel *pixel_6_0;
    IBOutlet Pixel *pixel_6_1;
    IBOutlet Pixel *pixel_6_2;
    IBOutlet Pixel *pixel_6_3;
    IBOutlet Pixel *pixel_6_4;
    IBOutlet Pixel *pixel_6_5;
    IBOutlet Pixel *pixel_6_6;
    IBOutlet Pixel *pixel_6_7;

    IBOutlet Pixel *pixel_7_0;
    IBOutlet Pixel *pixel_7_1;
    IBOutlet Pixel *pixel_7_2;
    IBOutlet Pixel *pixel_7_3;
    IBOutlet Pixel *pixel_7_4;
    IBOutlet Pixel *pixel_7_5;
    IBOutlet Pixel *pixel_7_6;
    IBOutlet Pixel *pixel_7_7;

    // Switches to paint specific rows
    IBOutlet NSButton *rowSwitch0;
    IBOutlet NSButton *rowSwitch1;
    IBOutlet NSButton *rowSwitch2;
    IBOutlet NSButton *rowSwitch3;
    IBOutlet NSButton *rowSwitch4;
    IBOutlet NSButton *rowSwitch5;
    IBOutlet NSButton *rowSwitch6;
    IBOutlet NSButton *rowSwitch7;

    // Switches to paint specific rows
    IBOutlet NSButton *colSwitch0;
    IBOutlet NSButton *colSwitch1;
    IBOutlet NSButton *colSwitch2;
    IBOutlet NSButton *colSwitch3;
    IBOutlet NSButton *colSwitch4;
    IBOutlet NSButton *colSwitch5;
    IBOutlet NSButton *colSwitch6;
    IBOutlet NSButton *colSwitch7;

    IBOutlet NSTextField *hexField;
    IBOutlet NSButton *stringButton;

    // FROM 1.3.0
    IBOutlet NSSwitch *colourSwitch;
    IBOutlet NSButton *redButton;
    IBOutlet NSButton *yellowButton;
    IBOutlet NSButton *greenButton;
    IBOutlet NSButton *inverseButton;
    IBOutlet NSMenuItem *inverseMenuItem;
    IBOutlet NSMenuItem *colourSwitchMenuItem;
    IBOutlet NSMenuItem *greenColourMenuItem;
    IBOutlet NSMenuItem *redColourMenuItem;
    IBOutlet NSMenuItem *yellowColourMenuItem;

    NSMutableArray *pixels;

    BOOL shiftSet, outputToString;

    // FROM 1.3.0
    // Record the current colour
    NSInteger inkColour;
}


- (void)paintAllPixels:(NSUInteger)color;
- (IBAction)calcHex:(id)sender;
- (IBAction)clearSet:(id)sender;
- (IBAction)fillSet:(id)sender;
- (IBAction)clearRow:(id)sender;
- (IBAction)clearCol:(id)sender;
- (IBAction)retroFill:(id)sender;
- (IBAction)inverse:(id)sender;
- (IBAction)rotate:(id)sender;
- (IBAction)setOutputType:(id)sender;
- (IBAction)flipHorizontal:(id)sender;
- (IBAction)flipVertical:(id)sender;

// FROM 1.3.0
- (IBAction)flipColourSwitch:(id)sender;
- (IBAction)setColour:(id)sender;
- (IBAction)showOnlineHelp:(id)sender;
- (void)setPaintColourMenuStates:(NSUInteger)colour;
- (NSUInteger)getHexValue:(NSInteger)index :(NSString *)string;
- (void)showError:(NSString *)title :(NSString *)message;

// FROM 1.4.0
- (IBAction)shiftLeft:(id)sender;
- (IBAction)shiftRight:(id)sender;
- (IBAction)shiftUp:(id)sender;
- (IBAction)shiftDown:(id)sender;
- (void)updateAll;


@property (assign) IBOutlet AsciiWindow *window;


@end
