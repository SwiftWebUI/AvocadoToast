//
//  AppDelegate.swift
//  AvocadoToast
//
//  Created by Helge Heß on 28.06.19.
//  Copyright © 2019 Helge Heß. All rights reserved.
//

import Cocoa
import WebKit
import SwiftWebUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate {

  @IBOutlet weak var window  : NSWindow!
  @IBOutlet weak var webView : WKWebView!
  
  let request = URLRequest(url: URL(string: "http://127.0.0.1:1338/Tinker/")!)

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    SwiftWebUI.serve(port: 1338, waitUntilDone: false) {
      MainPage()
    }

    webView.navigationDelegate = self
    
    // Give NIO a moment to bind
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
      self.webView.load(self.request)
      self.window.makeKeyAndOrderFront(nil)
    }
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication)
       -> Bool
  {
    return true
  }
}

