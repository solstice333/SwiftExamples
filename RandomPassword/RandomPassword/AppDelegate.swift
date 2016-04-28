//
//  AppDelegate.swift
//  RandomPassword
//
//  Created by poky on 2/23/16.
//  Copyright © 2016 poky. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   var mainWindowController: MainWindowController?
   
   func applicationDidFinishLaunching(aNotification: NSNotification) {
      /*
      // Create a window controller with a XIB file of the same name
      let mainWindowController = MainWindowController()
      
      // Put the window of the window controller on screen
      mainWindowController.showWindow(self)
      
      // Set the property to point to the window controller
      self.mainWindowController = mainWindowController
      */
      
      self.mainWindowController = MainWindowController()
      self.mainWindowController!.showWindow(self)
   }
   
   func applicationWillTerminate(aNotification: NSNotification) {
      // Insert code here to tear down your application
   }
}

