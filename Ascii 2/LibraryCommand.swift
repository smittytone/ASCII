/*
    LibraryCommand.swift
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


public struct LibraryCommand: Commands {
    
    @State var icons: [Icon]
    @State var clickFunction: (Int)->Void
    
    public var body: some Commands {
        CommandMenu("Icon Library") {
            // Iterate over the icon array to generate the menu
            ForEach(self.icons) { icon in
                Button(action: {
                    self.clickFunction(icon.id)
                }, label: {
                    // NOTE The following line is used in order to create the Image from a CGImage.
                    //      If we use an NSImage as the source, the rendering mode function appears
                    //      to be ignored - or renders incorrectly.
                    Image(decorative: self.getImage(icon), scale: 1.0).renderingMode(.template)
                    Text(icon.name)
                })
                Divider()
            }
        }
    }
    
    
    // MARK: - Lifecycle Functions
    
    init(icons: [Icon], clicker: @escaping (Int)->Void) {
        
        self.icons = icons
        self.clickFunction = clicker
    }


    // MARK: - Icon Functions
    
    /**
     Generate an image derived from the supplied icon data.
     
     - Note This currently handles monochrome images only.
     
     - Parameters
        - icon: An Icon instance, holding the bit data.
     
     - Returns The icon rendered as a CGImage.
     */
    func getImage(_ icon: Icon) -> CGImage {
        
        if let ctx = getNewDrawingContext() {
            // Clear the context backgound
            ctx.setFillColor(.clear)
            ctx.fill([CGRect(x: 0, y: 0, width: 64, height: 64)])
            
            // Parse the icon's UInt64 data and draw it as blocks of 8x8 pixels
            for col in 0..<8 {
                let colByte = (icon.data1 >> (col * 8)) & 0xFF
                for row in 0..<8 {
                    let bit = (colByte >> row) & 0x01
                    ctx.setFillColor(bit == 1 ? .white : .clear)
                    ctx.fill([CGRect(x: col * 8, y: row * 8, width: 8, height: 8)])
                }
            }
             
            // Convert the context to an NSImage for use in the menu
            if let image = ctx.makeImage() {
                ctx.draw(image, in: CGRect(x: 0, y: 0, width: 64, height: 64))
                return image
                //return NSImage.init(cgImage: image, size: NSSize(width: 64, height: 64))
            }
        }
        
        // This is a backstop and should never be reached
        return NSImage(size: NSSize(width: 64, height: 64)).cgImage(forProposedRect: nil, context: nil, hints: nil)!
    }


    /**
     Generate a new bitmap drawing context in which to draw an icon image.
     
     - Returns The context, or `nil` on error.
     */
    func getNewDrawingContext() -> CGContext? {
        
        let bitmapData: CFMutableData = CFDataCreateMutable(nil, 0)
        CFDataSetLength(bitmapData, CFIndex(16384))
        let bitmap = CFDataGetMutableBytePtr(bitmapData)
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        return CGContext(data: bitmap,
                         width: 64,
                         height: 64,
                         bitsPerComponent: 8,
                         bytesPerRow: 256,
                         space: colorSpace,
                         bitmapInfo: bitmapInfo.rawValue)
    }

}
