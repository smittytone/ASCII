/*
    MainView.swift
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


struct MainView: View {
    
    @Environment(PixelGrid.self) internal var model: PixelGrid
    
    //@State var values: String = ""
    
    
    var body: some View {
        @Bindable var boundModel: PixelGrid = self.model
        HStack {
            // MARK: BUTTON COLUMN
            VStack {
                PixelGridView()
                Spacer()
                HStack {
                    Text("Grid pixel values:")
                    Spacer()
                }
                TextField("", text: $boundModel.hexValues)
                HStack {
                    Picker(selection: $boundModel.outputChoice, label: Text("Output values as:")) {
                        Text("String").tag(OutputType.string.rawValue)
                        Text("Array").tag(OutputType.array.rawValue)
                    }
                    .pickerStyle(.radioGroup)
                    .horizontalRadioGroupLayout()
                    Spacer()
                }
            }
            .padding(16)
            .frame(width: 350)
            // MARK: BUTTON COLUMN
            VStack {
                Spacer()
                Button(action: self.fill, label: {
                    Text("Fill Grid")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                Button(action: self.clear, label: {
                    Text("Clear Grid")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                Button(action: self.invert, label: {
                    Text("Invert Pixels")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                Button(action: self.rotateClockwise, label: {
                    Text("Rotate Clockwise")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                Button(action: self.flipHorizontal, label: {
                    Text("Flip Horizontal")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                Button(action: self.flipVertical, label: {
                    Text("Flip Vertical")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                HStack {
                    Toggle("Use Colours:", isOn: $boundModel.inColourMode)
                        .frame(minWidth: 144, maxWidth: 144)
                        .toggleStyle(.switch)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom, 8)
                .padding(.top, 16)
                HStack {
                    Picker("", selection: $boundModel.colourChoice) {
                        Text("Red").tag(PixelColour.red.rawValue)
                        Text("Green").tag(PixelColour.green.rawValue)
                        Text("Orange").tag(PixelColour.orange.rawValue)
                    }
                    .pickerStyle(.radioGroup)
                    .disabled(!self.model.inColourMode)
                    Spacer()
                }
                Spacer()
                Button(action: self.g2v, label: {
                    Text("Grid to Values")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
                Button(action: self.v2g, label: {
                    Text("Values to Grid")
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .frame(minWidth: 140, maxWidth: 140)
                })
            }
            .padding(16)
            .frame(width: 180)
            .onChange(of: self.model.outputToString) {
                // If the TextField contains data, update it if the mode changes
                if !self.model.hexValues.isEmpty {
                    self.g2v()
                }
            }
        }
    }
}


#Preview {
    MainView()
}
