//
//  AsciiWindow.m
//  ASCII
//
//  Created by Tony Smith on 10/02/2014.
//  Copyright (c) 2014-18 Tony Smith. All rights reserved.
//

#import "AsciiWindow.h"

@implementation AsciiWindow

@synthesize shiftSet;


- (void)flagsChanged:(NSEvent *)theEvent {

    NSUInteger value = [theEvent modifierFlags];
    shiftSet = value & NSEventModifierFlagShift ? YES : NO;
}


@end
