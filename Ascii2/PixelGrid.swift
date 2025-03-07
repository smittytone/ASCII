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
    
    var currentColour: PixelColour = .black
    var hexValues: String = ""
    var showError = false
    var errorAlertTitle: String = ""
    var errorAlertMessage: String = ""

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
            return _outputChoice
        }
        set {
            _outputChoice = newValue
        }
    }
    
    var values: String {
        get {
            var formatString = "\\x%02X";
            if self.outputChoice == OutputType.array.rawValue {
                formatString = "0x%02X";
            }
            
            var hex = ""
            var intLeft: UInt64 = 0
            var intRight: UInt64 = 0
            
            for col in 0..<8 {
                var byteValueLeft: UInt = 0
                var byteValueRight: UInt = 0
                
                for row in 0..<8 {
                    if self.inColourMode {
                        // Two bytes per column
                        let indexColour = self.grid[col][row].rawValue
                        if indexColour & 0x02 != 0 {
                            byteValueLeft += (1 << row)
                        }
                        
                        if indexColour & 0x01 != 0 {
                            byteValueRight += (1 << row)
                        }
                    } else {
                        if self.grid[col][row] != .white {
                            byteValueLeft += (1 << row)
                        }
                    }
                }
                
                // Always add the left byte to the hex string
                hex += String(format: formatString, byteValueLeft)
                
                if self.inColourMode {
                    // Four colour LEDs, add the right byte to the hex string
                    hex += String(format: formatString, byteValueRight)
                    
                    // For the UInt64 values we need to interleave the L and R byte pairs
                    if col < 4 {
                        intLeft += UInt64(byteValueLeft << ((7 - (2 * col)) * 8))
                        intLeft += UInt64(byteValueRight << ((6 - (2 * col)) * 8))
                    } else {
                        intRight += UInt64(byteValueLeft << ((col + ((5 - col) * 3)) * 8))
                        intRight += UInt64(byteValueRight << ((7 - col) * 2 * 8))
                    }
                } else {
                    // Add the shifted left byte to the mono integer
                    intLeft += UInt64(byteValueLeft << ((7 - col) * 8))
                }
                
                // Add comma separators to array output
                if self.outputChoice == OutputType.array.rawValue && col < 7 {
                    hex += ","
                }
            }
            
            // Add brackets around the array values
            if self.outputChoice == OutputType.array.rawValue {
                hex = "[\(hex)]"
            }
            
            // Output string or array, if selected
            if self.outputChoice != OutputType.uint.rawValue {
                return hex
            }
            
            // Output UInt64 value(s)
            if self.inColourMode {
                return intLeft.description + "," + intRight.description
            } else {
                return intLeft.description
            }
        }
    }


    // MARK: - Private Properties
    
    private var grid: [[PixelColour]] = []
    private var _colourMode = false
    private var _colourChoice = PixelColour.red.rawValue
    private var _outputChoice = OutputType.string.rawValue
    

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


    /**
     Get the colour value of a specified grid cell.
     
     - Parameters
        - col: The cell's column.
        - row: The cell's row.
     
     - Returns The colour value
     */
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
        
        var tidyValues: String
        switch self.outputChoice {
            case OutputType.array.rawValue, OutputType.string.rawValue:
                // Tidy up the string as best as possible
                tidyValues = values.replacingOccurrences(of: ",", with: "")
                tidyValues = tidyValues.replacingOccurrences(of: "[", with: "")
                tidyValues = tidyValues.replacingOccurrences(of: "]", with: "")
                tidyValues = tidyValues.replacingOccurrences(of: "0x", with: "")
                tidyValues = tidyValues.replacingOccurrences(of: "\\x", with: "")
                
                // Chomp strings to the expected length
                if self.inColourMode && tidyValues.count > 32 {
                    tidyValues = String(tidyValues.dropLast(tidyValues.count - 32))
                }
                
                if !self.inColourMode && tidyValues.count > 16 {
                    tidyValues = String(tidyValues.dropLast(tidyValues.count - 16))
                }
                
                // Check the validity of the string
                if tidyValues.count % 2 != 0 {
                    //[self showError:@"Bad Hex String" :@"Enter a string that contains an even number of hex characters"];
                    showError("Mis-sized Hex String")
                    return
                }
                
                drawString(tidyValues)
            default:
                // One or two UInt64 values
                let haveColourData = values.contains(",")
                if self.inColourMode && !haveColourData {
                    showError("Unpaired colour UInt64")
                    return
                }
                
                if !self.inColourMode && haveColourData {
                    showError("Colour UInt64 pair provided")
                    return
                }
                
                drawInt(values, haveColourData)
        }
    }


    /**
     Render a hex string on the pixel grid.
     
     - Parameters
        - hex: The hex string.
     */
    func drawString(_ hex: String) {
        
        // Clear the grid
        fillAll(.white)
        
        // Set the pixels according to the supplied hex values
        var valueLeft: Int = 0
        var valueRight: Int = 0
        var byteLeft: Int
        var byteRight: Int
        var cursor: Int = 0
        var col = 0
        while (cursor < hex.count - 1) {
            if let vl = getHexValue(cursor, hex) {
                valueLeft = vl
            } else {
                showError("Bad hex string")
                return
            }
            
            cursor += 2
            
            if self.inColourMode {
                if let vr = getHexValue(cursor, hex) {
                    valueRight = vr
                } else {
                    showError("Bad hex string")
                    return
                }
                
                cursor += 2
            }
            
            for j in 0..<8 {
                byteLeft = valueLeft & (1 << j)
                if self.inColourMode {
                    // Use the bit values not only to determine if a pixel is set (either bit is 1)
                    // but the colour of the set pixel:
                    // Byte 1 Bit | Byte 2 Bit | Colour
                    // -----------+------------+--------
                    //     0      |      0     | None
                    //     1      |      0     | Green
                    //     0      |      1     | Red
                    //     1      |      1     | Orange
                    byteRight = valueRight & (1 << j)
                    if byteLeft != 0 || byteRight != 0 {
                        self.grid[col][j] = PixelColour(rawValue: ((byteLeft >> j) << 1) | (byteRight >> j)) ?? .red
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


    /**
     Render one or two UInt64 values to the grid.
     */
    func drawInt(_ values: String, _ haveColourData: Bool) {
        
        if haveColourData {
            let numbers = values.components(separatedBy: ",")
            guard let iconInt1: UInt64 = UInt64(numbers[0]) else {
                showError("Bad UInt64 value")
                return
            }
            
            guard let iconInt2: UInt64 = UInt64(numbers[1]) else {
                showError("Bad UInt64 value")
                return
            }
            
            for col in 0..<8 {
                var colByteLeft: UInt64 = 0
                var colByteRight: UInt64 = 0
                if col < 4 {
                    colByteLeft = (iconInt1 >> ((7 - (2 * col)) * 8)) & 0xFF
                    colByteRight = (iconInt1 >> ((6 - (2 * col)) * 8)) & 0xFF
                } else {
                    colByteLeft = (iconInt2 >> ((col + ((5 - col) * 3)) * 8)) & 0xFF
                    colByteRight = (iconInt2 >> ((7 - col) * 2 * 8)) & 0xFF
                }
                
                for row in 0..<8 {
                    let byteLeft = colByteLeft & (1 << row)
                    let byteRight = colByteRight & (1 << row)
                    if byteLeft != 0 || byteRight != 0 {
                        self.grid[col][row] = PixelColour(rawValue: Int(((byteLeft >> row) << 1) | (byteRight >> row))) ?? .red
                    }
                }
            }
        } else {
            guard let iconInt: UInt64 = UInt64(values) else {
                showError("Bad UInt64 value")
                return
            }
            
            for col in 0..<8 {
                let colByte = (iconInt >> (col * 8)) & 0xFF
                for row in 0..<8 {
                    let bit = (colByte >> row) & 0x01
                    self.grid[col][row] = (bit == 1 ? .black : .white)
                }
            }
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


    /**
     Trigger the presentation of the main view's Alert.
     
     - Parameters
        - title:   The alert title.
        - message: The alert message. Default: an empty string.
     */
    func showError(_ title: String, _ message: String = "") {
        
        self.errorAlertTitle = title
        self.errorAlertMessage = message
        self.showError = true
    }


    /*
    func presentIcon(_ idx: Int) {
        
        let icon = iconDecode(AsciiLibrary.icons[idx])
        retroFill(icon)
    }


     func iconDecode(_ icon: Icon) -> String {
         
         if icon.isColour {
             return icon.data1.hexstring + icon.data2.hexstring
         } else {
             return icon.data1.hexstring
         }
     }
     */


}
