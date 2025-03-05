/*
    PixelGrid.swift
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
import SwiftUI


@Observable
class PixelGrid {
    
    // MARK: - Public Properties
    
    var grid: [[PixelColour]] =         []
    var outputToString =                true
    var currentColour: PixelColour =    .black
    var hexValues: String =             ""
    
    // MARK: - Public Computed Properties
    
    var inColourMode: Bool {
        get {
            return self._colourMode
        }
        set {
            _colourMode = newValue
            if newValue {
                if self.currentColour == .black {
                    self.currentColour = PixelColour(rawValue: _colourChoice) ?? .red
                    self.colourChoice = self.currentColour.rawValue
                }
            } else {
                self.currentColour = .black
            }
            
            self.colourise()
        }
    }
    
    var colourChoice: Int {
        get {
            return self._colourChoice
        }
        set {
            _colourChoice = newValue
            self.currentColour = PixelColour(rawValue: newValue) ?? .black
        }
    }
    
    
    var outputChoice: Int {
        get {
            return self.outputToString ? OutputType.string.rawValue : OutputType.array.rawValue
        }
        set {
            outputToString = (newValue == OutputType.string.rawValue)
        }
    }
    
    var values: String {
        get {
            var theHex = ""
            let formatString = self.outputToString ? "\\x%02X" : "0x%02X";
            for col in 0..<8 {
                var byteValueLeft = 0
                var byteValueRight = 0
                
                for row in 0..<8 {
                    if self.inColourMode {
                        // Two bytes per column
                        let indexColour = self.grid[col][row].rawValue
                        if indexColour & 0x02 != 0 {
                            byteValueLeft += (1 << (7 - row))
                        }
                        
                        if indexColour & 0x01 != 0 {
                            byteValueRight += (1 << (7 - row))
                        }
                    } else {
                        if self.grid[col][row] != .white {
                            byteValueLeft += (1 << (7 - row))
                        }
                    }
                }
                
                theHex += String(format: formatString, byteValueLeft)
                if self.inColourMode {
                    theHex += String(format: formatString, byteValueRight)
                }
                
                if !outputToString && col < 7 {
                    theHex += ","
                }
            }
            
            if !outputToString {
                theHex = "[\(theHex)]"
            }
            
            return theHex
        }
    }
    
    
    // MARK: - Private Properties
    
    private var _colourMode = false
    private var _colourChoice = PixelColour.red.rawValue
    
    
    // MARK: - Lifecycle Functions
    
    init() {
        grid = Array(repeating: Array(repeating: .white, count: 8), count: 8)
        
        // Kind of a UI thing so should not be here!
        UserDefaults.standard.setValue(false, forKey: "NSQuitAlwaysKeepsWindows")
    }
    
    
    // MARK: - Graphics Functons
    
    /**
     Set a specific pixel's colour.
     
     - Parameters
        - col:    The pixel's X co-ordinate.
        - row:    The pixel's Y co-ordinate.
        - colour: The pixel's colour. Default: .black
     */
    func plot(_ col: Int, _ row: Int, _ colour: PixelColour = .black) {
        
        self.grid[col][row] = colour
    }
    
    
    func colour(_ col: Int, _ row: Int) -> PixelColour {
        
        return self.grid[col][row]
    }
    
    
    /**
     Set a row of pixels to the same colour.
     
     - Parameters
        - row:    The row's Y co-ordinate.
        - colour: The pixel's colour. Default: .black
     */
    func fillRow(_ row: Int, _ colour: PixelColour = .black, _ doClear: Bool = false) {
        
        guard (row >= 0 && row < 8) else { return }
        for col in 0..<8 {
            self.grid[col][row] = doClear ? .white : colour
        }
    }
    
    
    /**
     Set a column of pixels to the same colour.
     
     - Parameters
        - col:    The row's Y co-ordinate.
        - colour: The pixel's colour. Default: .black
     */
    func fillColumn(_ col: Int, _ colour: PixelColour = .black, _ doClear: Bool = false) {
        
        guard (col >= 0 && col < 8) else { return }
        for row in 0..<8 {
            self.grid[col][row] = doClear ? .white : colour
        }
    }
    
    
    /**
     Set all pixels to the same colour.
     
     - Parameters
        - colour: The pixel's colour. Default: .black
     */
    func fillAll(_ colour: PixelColour = .black) {
        
        for i in 0..<8 {
            for j in 0..<8 {
                self.grid[i][j] = colour
            }
        }
    }
    
    
    /**
     Reverse all pixels: set to unset, unset to set
     */
    func invertAll() {
        
        for col in 0..<8 {
            for row in 0..<8 {
                self.grid[col][row] = self.grid[col][row] == .white ? .black : .white
            }
        }
    }
    
    
    /**
     Flip the grid horizontally, ie. reverse the row order.
     */
    func flipHorizontal() {
        
        var tempGrid: [[PixelColour]] = Array(repeating: Array(repeating: .white, count: 8), count: 8)

        for col in 0..<8 {
            for row in 0..<8 {
                tempGrid[col][row] = self.grid[7 - col][row]
            }
        }
        
        self.grid = tempGrid
    }
    
    
    /**
     Flip the grid vertically, ie. reverse the column order.
     */
    func flipVertical() {
        
        var tempGrid: [[PixelColour]] = Array(repeating: Array(repeating: .white, count: 8), count: 8)

        for col in 0..<8 {
            for row in 0..<8 {
                tempGrid[col][row] = self.grid[col][7 - row]
            }
        }
        
        self.grid = tempGrid
    }
    
    
    /**
     Rotate the grid 90 degrees clockwise.
     */
    func rotate() {
        
        var tempGrid: [[PixelColour]] = self.grid
        
        for col in 0..<4 {
            for row in col..<7-col {
                let temp = tempGrid[col][row]
                tempGrid[col][row] = tempGrid[7 - row][col]
                tempGrid[7 - row][col] = tempGrid[7 - col][7 - row]
                tempGrid[7 - col][7 - row] = tempGrid[row][7 - col]
                tempGrid[row][7 - col] = temp
            }
        }
        
        self.grid = tempGrid
    }
    
    
    /**
     Move the grid one column to the left.
     */
    func shiftLeft() {
        
        for col in 0..<7 {
            for row in 0..<8 {
                self.grid[col][row] = self.grid[col + 1][row]
            }
        }
        
        fillColumn(7, .white)
    }
    
    
    /**
     Move the grid one column to the right.
     */
    func shiftRight() {
        
        for col in (1..<8).reversed() {
            for row in 0..<8 {
                self.grid[col][row] = self.grid[col - 1][row]
            }
        }
        
        fillColumn(0, .white)
    }
    
    
    /**
     Move the grid one row down.
     */
    func shiftDown() {
        
        for row in 0..<7 {
            for col in 0..<8 {
                self.grid[col][row] = self.grid[col][row + 1]
            }
        }
        
        fillRow(7, .white)
    }
    
    
    /**
     Move the grid one row up.
     */
    func shiftUp() {
        
        for row in (1..<8).reversed() {
            for col in 0..<8 {
                self.grid[col][row] = self.grid[col][row - 1]
            }
        }
        
        fillRow(0, .white)
    }
    
    
    /**
     Populate the grid from a string of hex values.
     There are 16 values (32 characters) for a colour grid, or
     eight values for a monochrome grid.
     
     - Parameters
        - values: The string of hex values.
     */
    func retroFill(_ values: String) {
        
        // Make sure we have a string to work with
        guard values.count > 0 else { return }
        
        // Tidy up the string as best as possible
        var tidyValues = values.replacingOccurrences(of: ",", with: "")
        if !self.outputToString {
            tidyValues = tidyValues.replacingOccurrences(of: "[", with: "")
            tidyValues = tidyValues.replacingOccurrences(of: "]", with: "")
            tidyValues = tidyValues.replacingOccurrences(of: "0x", with: "")
        } else {
            tidyValues = tidyValues.replacingOccurrences(of: "\\x", with: "")
        }
        
        // Check the validity of the string
        if tidyValues.count % 2 != 0 {
            //[self showError:@"Bad Hex String" :@"Enter a string that contains an even number of hex characters"];
            return
        }
        
        // Chomp strings to the expected length
        if self.inColourMode && tidyValues.count > 32 {
            tidyValues = String(tidyValues.dropLast(tidyValues.count - 32))
        }
        
        if !self.inColourMode && tidyValues.count > 16 {
            tidyValues = String(tidyValues.dropLast(tidyValues.count - 16))
        }
        
        // Clear the grid
        fillAll(.white)
        
        // Set the pixels according to the supplied hex values
        var valueLeft: Int = 0
        var valueRight: Int = 0
        var byteLeft: Int
        var byteRight: Int
        var cursor: Int = 0
        var col = 0
        while (cursor < tidyValues.count - 1) {
            if let vl = getHexValue(cursor, tidyValues) {
                valueLeft = vl
            } else {
                return
            }
            
            cursor += 2
            
            if self.inColourMode {
                if let vr = getHexValue(cursor, tidyValues) {
                    valueRight = vr
                } else {
                    return
                }
                
                cursor += 2
            }
            
            for j in 0..<8 {
                byteLeft = valueLeft & (1 << (7 - j))
                
                if self.inColourMode {
                    // Use the bit values not only to determine if a pixel is set (either bit is 1)
                    // but the colour of the set pixel:
                    // Byte 1 Bit | Byte 2 Bit | Colour
                    // -----------+------------+--------
                    //     0      |      0     | None
                    //     1      |      0     | Green
                    //     0      |      1     | Red
                    //     1      |      1     | Orange
                    byteRight = valueRight & (1 << (7 - j))
                    if byteLeft != 0 || byteRight != 0 {
                        self.grid[col][j] = PixelColour(rawValue: ((byteLeft >> (7 - j)) << 1) | (byteRight >> (7 - j))) ?? .red
                    }
                } else {
                    // For a mono display, if the bit is set, the pixel is lit
                    if byteLeft != 0 {
                        self.grid[col][j] = .black
                    }
                }
            }
            
            // Check that we're not going to break the loop
            if self.inColourMode && cursor > 28 { break }
            if !self.inColourMode && cursor > 14 { break }
            
            // Move to the next row
            col += 1
        }
    }


    // MARK: - Utility Functions
    /**
     Convert a two hex characters within a string to an interger.
     
     - Parameters
        - index: The index of the first of the two characters within the string.
        - hex:   The string of hex octets.
     
    - Returns The integer value, or `nil` on error.
     */
    func getHexValue(_ index: Int, _ hex: String) -> Int? {
        
        var value: Int64 = 0
        let range = NSMakeRange(index, 2)
        let sub = (hex as NSString).substring(with: range)
        let scanner = Scanner(string: sub)
        
        // Check if the scanning acutally worked
        let success = scanner.scanHexInt64(&value)
        
        // It didn't, so show an error and bail
        if success {
            return Int(value)
        }
        
        return nil
    }
    
    
    /**
     Set any black pixels to the current non-black colour.
     This is called if the user moves from a monochrome grid to a
     colour one.
     */
    func colourise() {
        
        // Only proceed if we're in colour mode
        guard self.inColourMode else { return }
        
        for col in 0..<8 {
            for row in 0..<8 {
                if self.grid[col][row] == .black {
                    self.grid[col][row] = self.currentColour
                }
            }
        }
    }

}
