/*
    Ascii2App.swift
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
import Cocoa


@main
struct Ascii2App: App {
    
    // Hack required to remove the redundant View menu
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Customise the About... window
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    // Make the openURL function available
    @Environment(\.openURL) private var openURL
    
    
    @State private var model = PixelGrid()
    @State private var actionMenuColourTitles = ["Switch to Colour Mode", "Switch to Mono Mode"]
    @State private var actionMenuColourTitleIndex = 0
    @State private var showingAboutWindow = false
    
    
    var body: some Scene {
        // MARK: ASCII WINDOW
        Window("ASCII", id: "main") {
            MainView()
                .environment(self.model)
                .frame(width: 548, height: 458)
                // The following added for macOS 15 builds which enforces appearance of the zoom button
                .onReceive(NotificationCenter.default.publisher(for:
                    NSWindow.didBecomeKeyNotification)) { notification in
                    if let window = notification.object as? NSWindow {
                        // Remove the zoom button for all windows
                        window.standardWindowButton(.zoomButton)?.isHidden = true
                        if self.showingAboutWindow {
                            // Remove the miniaturize button if we're making the `about` window key
                            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                            self.showingAboutWindow = false
                        }
                    }
                }
        }
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unified)
        .defaultPosition(.center)
        .defaultSize(CGSize(width: 548, height: 458))
        .restorationBehavior(.disabled) // macOS 15+ only
        .commands {
            // MARK: HELP MENU
            CommandGroup(replacing: .help) {
                // Update the Help command to open a browser and get web-sourced help
                Button("ASCII Help") {
                    if let url = URL(string: "https://smittytone.net/ascii/index.html") {
                        openURL(url)
                    }
                }
                .keyboardShortcut("h", modifiers: [.command, .shift])
            }
            // MARK: APP MENU
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button("About ASCII") {
                    // Open the About.. window
                    self.showingAboutWindow = true
                    openWindow(id: "com.bps.ascii.about")
                }
            }
            // MARK: ACTIONS MENU
            CommandMenu("Actions") {
                Button("Fill Grid") {
                    self.model.fillAll(self.model.currentColour)
                }
                .keyboardShortcut("f", modifiers: .command)
                Button("Clear Grid") {
                    self.model.fillAll(.white)
                }
                .keyboardShortcut("k", modifiers: .command)
                Button("Invert Grid") {
                    self.model.invertAll()
                }
                .keyboardShortcut("i", modifiers: .command)
                Divider()
                Button("Rotate Grid Clockwise") {
                    self.model.rotate()
                }
                .keyboardShortcut("r", modifiers: .command)
                Button("Flip Grid Horizontally") {
                    self.model.flipHorizontal()
                }
                .keyboardShortcut("h", modifiers: [.command, .shift])
                Button("Flip Grid Vertically") {
                    self.model.flipVertical()
                }
                .keyboardShortcut("v", modifiers: [.command, .shift])
                Divider()
                Button("Shift Pixels Left") {
                    self.model.shiftLeft()
                }
                .keyboardShortcut(.leftArrow, modifiers: .command)
                Button("Shift Pixels Right") {
                    self.model.shiftRight()
                }
                .keyboardShortcut(.rightArrow, modifiers: .command)
                Button("Shift Pixels Up") {
                    self.model.shiftUp()
                }
                .keyboardShortcut(.upArrow, modifiers: .command)
                Button("Shift Pixels Down") {
                    self.model.shiftDown()
                }
                .keyboardShortcut(.downArrow, modifiers: .command)
                Divider()
                Button(self.actionMenuColourTitles[self.actionMenuColourTitleIndex]) {
                    self.model.inColourMode.toggle()
                    self.actionMenuColourTitleIndex = (self.actionMenuColourTitleIndex + 1) % 2
                }
                Picker("Ink Colour", selection: $model.colourChoice) {
                    Text("Red").tag(PixelColour.red.rawValue)
                    Text("Green").tag(PixelColour.green.rawValue)
                    Text("Orange").tag(PixelColour.orange.rawValue)
                }
                .disabled(!self.model.inColourMode)
                Divider()
                Button("Convert Grid to Values") {
                    self.model.hexValues = "\(self.model.values)"
                }
                .keyboardShortcut("g", modifiers: .command)
                Button("Write Values to Grid") {
                    guard !self.model.hexValues.isEmpty else { return }
                    self.model.retroFill(self.model.hexValues)
                }
                .keyboardShortcut("g", modifiers: [.command, .shift])
            }
        }
        // MARK: ABOUT WINDOW
        Window("About ASCII", id: "com.bps.ascii.about") {
            AboutView()
                .frame(width: 320, height: 240)
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .defaultPosition(.center)
        .defaultSize(CGSize(width: 320, height: 240))
        .restorationBehavior(.disabled) // macOS 15+ only
    }
}


/*
 This is part of the hack to remove the View menu.
 See https://gist.github.com/othyn/98f35abf988bdcfb6a118b8573d46b3b
 
 It is also used to quit the app when the last window (`main` or `about`) closes, which
 otherwise does not occur. This is sub-optimal so may warrant removing the custom
 `about` window altogether.
 
 NOTE Other menus may be removed this way: just replicate the inner statement
      and specify a different menu title.
 */
final class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillUpdate(_ notification: Notification) {
        if let menu = NSApplication.shared.mainMenu {
            if let file = menu.items.first(where: { $0.title == "View"}) {
                menu.removeItem(file);
            }
        }
    }
    
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        return true
    }
}
