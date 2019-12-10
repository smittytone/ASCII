//
//  AppDelegate.h
//  ASCII
//
//  Created by Tony Smith on 01/02/2014.
//  Copyright (c) 2014-18 Tony Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Pixel.h"
#import "AsciiWindow.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

{
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

    IBOutlet NSButton *rowSwitch0;
    IBOutlet NSButton *rowSwitch1;
    IBOutlet NSButton *rowSwitch2;
    IBOutlet NSButton *rowSwitch3;
    IBOutlet NSButton *rowSwitch4;
    IBOutlet NSButton *rowSwitch5;
    IBOutlet NSButton *rowSwitch6;
    IBOutlet NSButton *rowSwitch7;

    IBOutlet NSButton *colSwitch0;
    IBOutlet NSButton *colSwitch1;
    IBOutlet NSButton *colSwitch2;
    IBOutlet NSButton *colSwitch3;
    IBOutlet NSButton *colSwitch4;
    IBOutlet NSButton *colSwitch5;
    IBOutlet NSButton *colSwitch6;
    IBOutlet NSButton *colSwitch7;

    IBOutlet NSTextField *hexField;

    NSMutableArray *pixels;

    BOOL shiftSet;
}

- (IBAction)calcHex:(id)sender;
- (IBAction)clearSet:(id)sender;
- (IBAction)fillSet:(id)sender;
- (IBAction)clearRow:(id)sender;
- (IBAction)clearCol:(id)sender;
- (IBAction)retroFill:(id)sender;
- (IBAction)inverse:(id)sender;
- (IBAction)rotate:(id)sender;

@property (assign) IBOutlet AsciiWindow *window;

@end
