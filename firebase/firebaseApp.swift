//
//  firebaseApp.swift
//  firebase
//
//  Created by Gaming Lab on 21/11/24.
//

import SwiftUI

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
