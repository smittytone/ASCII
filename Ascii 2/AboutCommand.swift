/*
    AboutCommand.swift
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


public struct AboutCommand: Commands {
    
    private let title: String
    private let options: [NSApplication.AboutPanelOptionKey: Any]
    
    public var body: some Commands {
        CommandGroup(replacing: .appInfo) {
            Button(self.title) {
                NSApplication.shared.orderFrontStandardAboutPanel(options: self.options)
            }
        }
    }
    
    
    // MARK: - Lifecycle Functions
    
    public init(title: String, appName: String = Bundle.main.appName, blurb: String? = nil) {

        let options: [NSApplication.AboutPanelOptionKey: Any]
        if let blurb {
            options = [
                .applicationName: appName,
                .credits: NSAttributedString(string: blurb,
                                             attributes: [
                                                .foregroundColor: NSColor.secondaryLabelColor,
                                                .font: NSFont.systemFont(ofSize: NSFont.smallSystemFontSize)
                                             ])
            ]
        } else {
            options = [.applicationName: appName]
        }
        
        self.init(title: title, options: options)
    }
    
    public init(title: String, options: [NSApplication.AboutPanelOptionKey: Any]) {
    
        self.title = title
        self.options = options
    }

}
