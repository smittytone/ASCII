/*
    AboutView.swift
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


struct AboutView: View {
    
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 64.0, height: 64.0)
            Text("ASCII \(Bundle.main.version) (\(Bundle.main.build))")
                .foregroundStyle(.primary)
            Text("\nUse ASCII to create custom glyphs and images for monochrome and bi-colour 8x8 LED matrix displays.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
            Text("ASCII © 2025 Tony Smith (@smittytone).\nAll rights reserved")
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
        }
        .padding(16)
    }
}
