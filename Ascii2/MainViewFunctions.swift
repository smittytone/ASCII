/*
    MainViewFunctons.swift
    ASCII 2

    Copyright © 2025 Tony Smith. All rights reserved.

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

import Foundation


/*
 These are the functions provided by MainView, separated out for clarity
 */
extension MainView {
    
    /**
     Fill all the pixels with the current colour
     */
    func fill() {
        
        let colour = indexToColour()
        self.model.fillAll(colour)
    }
    
    
    /**
     Set all the pixels white to clear the grid
     */
    func clear() {
        
        self.model.fillAll(.white)
    }
    
    
    /**
     Invert all the pixels
     
     TODO Check what happens for colour pixels
     */
    func invert() {
        
        self.model.invertAll()
    }
    
    
    /**
     Swap the columns around
     */
    func flipHorizontal() {
        
        self.model.flipHorizontal()
    }
    
    
    /**
     Swap the rows around
     */
    func flipVertical() {
        
        self.model.flipVertical()
    }
    
    
    /**
     Rotate the grid 90 degrees clockwise
     */
    func rotateClockwise() {
        
        self.model.rotate()
    }
    
    
    /**
     Scan the grid and generate a hex string based on a mono
     or colour encoding.
     
     This updates the view's TextField
     */
    func g2v() {
        
        self.values = "\(self.model.values)"
    }
    
    
    /**
     Take the values from the view's TextField and decode them
     into the grid's pixel colour values
     */
    func v2g() {
        
        self.model.retroFill(self.values)
    }
    
    
    /**
     Convert a colour value from the currently selected colour
     */
    func indexToColour() -> PixelColour {
        
        if self.model.inColourMode {
            switch self.model.colourChoice {
                case 1:
                    return .red
                case 2:
                    return .green
                case 3:
                    return .orange
                default:
                    return .black
                
            }
        }
        
        return .black
    }
}
