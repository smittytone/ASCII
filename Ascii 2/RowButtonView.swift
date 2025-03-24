/*
    RowButton.swift
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
 This builds a row or column filler button.
 */
struct RowButtonView: View {
    
    @Environment(PixelGrid.self) private var model: PixelGrid
    
    @State var rowNumber = 0
    @State var isColumn = false
    
    @State private var shiftKeyPressed: Bool = false
    
    
    var body: some View {
        
        Image(systemName: isColumn ? "arrowtriangle.up.circle.fill" : "arrowtriangle.left.circle.fill")
            .resizable(resizingMode: .stretch)
            .frame(width: 16, height: 16)
            .onModifierKeysChanged(mask: .shift) { old, new in // macOS 15+ only
                self.shiftKeyPressed = !new.isEmpty
            }
            .onTapGesture {
                self.paintRow()
            }
    }
    
    
    /**
     Tell the model to fill the button's referenced row or column.
     */
    func paintRow() {
        
        if self.isColumn {
            self.model.fillColumn(self.rowNumber, self.model.currentColour, self.shiftKeyPressed)
        } else {
            self.model.fillRow(self.rowNumber, self.model.currentColour, self.shiftKeyPressed)
        }
    }
}
