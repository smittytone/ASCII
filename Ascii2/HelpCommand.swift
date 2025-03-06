/*
    HelpCommand.swift
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


public struct HelpCommand: Commands {
    
    // Make the `openURL` function available
    @Environment(\.openURL) private var openURL
    
    private let title: String
    private let link: String
    
    public var body: some Commands {
        CommandGroup(replacing: .help) {
            Button(self.title) {
                if let url = URL(string: self.link) {
                    openURL(url)
                }
            }
            .keyboardShortcut("h", modifiers: [.command, .shift])
        }
    }
    
    
    // MARK: - Lifecycle Functions
    
    public init(title: String, link: String) {
    
        self.title = title
        self.link = link
    }

}
