//
//  MainWindowController.swift
//  RandomPassword
//
//  Created by poky on 2/23/16.
//  Copyright © 2016 poky. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
   @IBOutlet weak var textField: NSTextField!
   
   override var windowNibName: String? {
      return "MainWindowController"
   }
   
   override func windowDidLoad() {
      super.windowDidLoad()
      
      // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
   }
   
   @IBAction func generatePassword(sender: AnyObject) {
      // Tell the text field what to display
      textField.stringValue = generateRandomString(10)
   }
}
