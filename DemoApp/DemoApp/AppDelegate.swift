// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication
      .LaunchOptionsKey: Any]?) -> Bool
  {
    // Override point for customization after application launch.
    true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions) -> UISceneConfiguration
  {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role)
  }

  func application(
    _ application: UIApplication,
    didDiscardSceneSessions sceneSessions: Set<UISceneSession>)
  {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

