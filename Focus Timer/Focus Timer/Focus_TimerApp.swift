//
//  Focus_TimerApp.swift
//  Focus Timer
//
//  Created by Tom Leigh on 13/10/2022.
//

import SwiftUI

@main
struct Focus_TimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        MenuBarExtra("Focus Timer", systemImage: "timer") {
            MainView()
        }.menuBarExtraStyle(.window)
    }
}
