/*
    PixelView.swift
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

import SwiftUI


/*
 This builds a single pixel cell on the main icon grid.
 */
struct PixelView: View {
    
    @Environment(PixelGrid.self) private var model: PixelGrid
    
    @State var x = 0
    @State var y = 0
    
    var body: some View {
        
        Color(getColour(self.model.colour(x, y)))
            .border(Color.gray, width: 0.5)
            .frame(width: 32.0, height: 32.0)
    }
    
    
    /**
     Return an actual colour for whatever hue is specified.
     
     - Parameters
        - colour: A specified PixelColour value.
     
     - Returns The mapped NSColor.
     */
    func getColour(_ colour: PixelColour) -> NSColor {
        
        // In mono mode, return black or white whatever the colour the pixel is set to
        if !self.model.inColourMode {
            return colour == .white ? .white : .black
        }
        
        switch colour {
            case .red:    return .red
            case .green:  return .green
            case .orange: return .orange
            case .black:  return .black
            default:      return .white
        }
    }
}
