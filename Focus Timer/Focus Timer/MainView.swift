//
//  MainView.swift
//  Focus Timer
//
//  Created by Tom Leigh on 13/10/2022.
//

import SwiftUI
import AVKit

/// The core window in the menu bar
struct MainView: View {
    @State private var settingsOpen: Bool  = false
    @State var audioPlayer: AVAudioPlayer!
    @AppStorage("progressTime") var progressTime: Int = 0
    @State var isRunning: Bool = false
    @AppStorage("isMuted") var isMuted: Bool = false
    @AppStorage("volume") var volume : Double = 1.0
    @AppStorage("colourTheme") var colourTheme : String = "Default"
    @AppStorage("soundscape") var soundscape : String = "Rain"
    @State var soundInitialised : Bool = false
    
    // Increase progressTime each second
    @State private var timer: Timer?
    
    var body: some View {
        VStack (spacing: 0) {
            /// TitleBar is persistent across the TimerView and SettingsView
            TitleBar(settingsOpen: $settingsOpen)
                .padding(.top, 5)
                .transaction { transaction in
                    transaction.animation = nil
                }
            
            if(settingsOpen) {
                SettingsView(settingsOpen: $settingsOpen, audioPlayer: $audioPlayer, volume: $volume, colourTheme: $colourTheme, soundscape: $soundscape)
                    .transition(.moveAndFadeLeft)
                    .frame(width: 150)
                
            } else {
                TimerView(settingsOpen: $settingsOpen, audioPlayer: $audioPlayer,volume: $volume, progressTime: $progressTime, isRunning: $isRunning, isMuted: $isMuted, soundInitialised: $soundInitialised, timer: $timer)
                    .transition(.moveAndFadeRight)
                    .frame(width: 150)
                
            }
        }
        
        .background(.thickMaterial)
        .background(setThemeColor())
    }
    
    /// Used to change the colour theme of the menu panel (background colour)
    func setThemeColor() -> Color {
        switch (colourTheme) {
        case "Blue": return .blue
        case "Green": return .green
        case "Orange" : return .orange
        case "Pink": return .pink
        case "Red": return .red
        case "Yellow": return .yellow
        case "Default": return .clear
            
        default:
            return .clear
        }
    }
}

/// A set of transitions between windows. Used to scale and fade between settings and timer views.
extension AnyTransition {
    static var moveAndFadeLeft: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .trailing).combined(with: .opacity)
        )
    }
    static var moveAndFadeRight: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .leading).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        )
    }
    static var ScaleFade: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 1.1).combined(with: .opacity),
            removal: .scale(scale: 0.9).combined(with: .opacity)
        )
    }
}
