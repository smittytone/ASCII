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
    
    var body: some View {
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
                RowButton(rowNumber: 7)
                    .padding(.leading)
            }
            GridRow {
                Text("6")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 6) }
                RowButton(rowNumber: 6)
                    .padding(.leading)
            }
            GridRow {
                Text("5")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 5) }
                RowButton(rowNumber: 5)
                    .padding(.leading)
            }
            GridRow {
                Text("4")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 4) }
                RowButton(rowNumber: 4)
                    .padding(.leading)
            }
            GridRow {
                Text("3")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 3) }
                RowButton(rowNumber: 3)
                    .padding(.leading)
            }
            GridRow {
                Text("2")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 2) }
                RowButton(rowNumber: 2)
                    .padding(.leading)
            }
            GridRow {
                Text("1")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 1) }
                RowButton(rowNumber: 1)
                    .padding(.leading)
            }
            GridRow {
                Text("0")
                    .padding(.trailing)
                ForEach(0..<8) { x in PixelView(x: x, y: 0) }
                RowButton(rowNumber: 0)
                    .padding(.leading)
            }
            GridRow {
                Text(" ")
                ForEach(0..<8) { i in
                    RowButton(rowNumber: i, isColumn: true)
                        .padding(.top)
                }
            }
        }
    }
}
