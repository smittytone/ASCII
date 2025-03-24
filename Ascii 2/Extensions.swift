/*
    Extensions.swift
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

import AppKit


public extension Bundle {
    
    var version: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "UNKNOWN"
    }
    
    var build: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? "UNKNOWN"
    }
    
    var appName: String {
        return infoDictionary?["CFBundleDisplayName"] as? String ?? "UNKNOWN"
    }
}


public extension UInt64 {
    
    /**
     Convert and return the value as a hexadecimal string representation.
     */
    var hexstring: String {
        var s = ""
        for i in 0..<8 {
            s += String(format: "%02x", (self >> ((7 - i) * 8)) & 0xFF)
        }
        
        return s
    }
}


public extension NSColor {
    
    /**
     Generate a CGColor version of the NSColor.
     */
    var cgColor: CGColor? {
        let colourSpace = CGColorSpaceCreateDeviceRGB()
        guard let adaptedSelf = self.usingType(.componentBased) else { return .black }
        let colourValues: [CGFloat] = [adaptedSelf.redComponent, adaptedSelf.greenComponent, adaptedSelf.blueComponent, adaptedSelf.alphaComponent]
        return CGColor(colorSpace: colourSpace, components: colourValues)
    }
}
