//
//  KDE_Connect_TestApp.swift
//  KDE Connect Test
//
//  Created by Lucas Wang on 2021-06-17.
//

import SwiftUI

@main
struct KDE_Connect_TestApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
    
    var linkProvider = LanLinkProvider(delegate:nil)
}
