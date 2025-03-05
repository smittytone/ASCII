/*
    PixelViewGrid.swift
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
 This builds the primary pixel grid, including its axes and fill row/column buttons.
 */
struct PixelGridView: View {
    
    @Environment(PixelGrid.self) private var model: PixelGrid
    
    @State private var lastRow = -1
    @State private var lastCol = -1
    @State private var isDragging = false
    @State private var paintColour: PixelColour = .black
    
    var body: some View {
        ZStack {
           Grid(horizontalSpacing: 0.0, verticalSpacing: 0.0) {
                GridRow {
                    Text(" ")
                    ForEach(0..<8) { i in
                        Text("\(i)")
                            .padding(.bottom)
                    }
                    Text(" ")
                }
                GridRow {
                    Text("7")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 7) }
                    RowButtonView(rowNumber: 7)
                        .padding(.leading)
                }
                GridRow {
                    Text("6")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 6) }
                    RowButtonView(rowNumber: 6)
                        .padding(.leading)
                }
                GridRow {
                    Text("5")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 5) }
                    RowButtonView(rowNumber: 5)
                        .padding(.leading)
                }
                GridRow {
                    Text("4")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 4) }
                    RowButtonView(rowNumber: 4)
                        .padding(.leading)
                }
                GridRow {
                    Text("3")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 3) }
                    RowButtonView(rowNumber: 3)
                        .padding(.leading)
                }
                GridRow {
                    Text("2")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 2) }
                    RowButtonView(rowNumber: 2)
                        .padding(.leading)
                }
                GridRow {
                    Text("1")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 1) }
                    RowButtonView(rowNumber: 1)
                        .padding(.leading)
                }
                GridRow {
                    Text("0")
                        .padding(.trailing)
                    ForEach(0..<8) { x in PixelView(x: x, y: 0) }
                    RowButtonView(rowNumber: 0)
                        .padding(.leading)
                }
                GridRow {
                    Text(" ")
                    ForEach(0..<8) { i in
                        RowButtonView(rowNumber: i, isColumn: true)
                            .padding(.top)
                    }
                }
            }
            Grid(horizontalSpacing: 0.0, verticalSpacing: 0.0) {
                GridRow {
                    // Here we're overlaying a single transparent (mostly) square over
                    // the pixel grid. This square will recieve tap and drag events, and
                    // update the model accordingly. These changes filter through to the
                    // pixels themselves (referenced above) and they will update accordingly
                    //
                    // NOTE This square does not perfectly align with the underlying grid, but
                    //      it's close enough - only a few points out horizontally
                    Color(Color.gray.opacity(0.01))
                        //.border(Color.red, width: 0.75)
                        .frame(width: 256.0, height: 256.0)
                        .onTapGesture { location in
                            // Get the current cell co-ordinates
                            let col = Int(location.x / 32)
                            let row = 7 - Int(location.y / 32)
                            
                            // Apply colour on white, or white if the cell is already coloured
                            let newColour: PixelColour = self.model.colour(col, row) == self.model.currentColour ? .white : self.model.currentColour
                            
                            // Just set the model data: the grid will update accordingly
                            self.model.plot(col, row, newColour)
                        }
                        .gesture(
                            DragGesture(minimumDistance: 5)
                                .onChanged { value in
                                    var col = 99
                                    var row = 99
                                    
                                    if !self.isDragging {
                                        // We're at the start of the process, so get the colour of the clicked
                                        // pixel and store it until we're done
                                        col = Int(value.startLocation.x / 32)
                                        row = 7 - Int(value.startLocation.y / 32)
                                        self.paintColour = self.model.colour(col, row) == self.model.currentColour ? .white : self.model.currentColour
                                        self.isDragging = true
                                    } else {
                                        // Get the current cell
                                        col = Int(value.location.x / 32)
                                        row = 7 - Int(value.location.y / 32)
                                    }
                                    
                                    // Bail if we're out of range, or still in the most recently painted cell
                                    guard col >= 0 && col < 8 && row >= 0 && row < 8 else { return }
                                    guard col != self.lastCol || row != lastRow else { return }
                                    
                                    // Fill the cell via the model
                                    self.model.plot(col, row, paintColour)
                                    self.lastRow = row
                                    self.lastCol = col
                                }
                                .onEnded { _ in
                                    // Done dragging so zap the state
                                    self.lastRow = -1
                                    self.lastCol = -1
                                    self.isDragging = false
                                }
                        )
                        
                }
            }
            
        }
    }
}
