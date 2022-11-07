//
//  MainView.swift
//  Focus Timer
//
//  Created by Tom Leigh on 13/10/2022.
//

import SwiftUI
import AVKit


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
    
    
    //@AppStorage("username") var username: String = "Anonymous"

    
    // Increase progressTime each second
    @State private var timer: Timer?
    
    var body: some View {
        VStack (spacing: 0) {
            TitleBar(settingsOpen: $settingsOpen)
                .padding(.top, 5)
                .transaction { transaction in
                    transaction.animation = nil
                }
            
            if(settingsOpen) {
                SettingsView(settingsOpen: $settingsOpen, audioPlayer: $audioPlayer, volume: $volume, colourTheme: $colourTheme, soundscape: $soundscape)
                    .transition(.ScaleFade)
                    .frame(width: 150)
                    .animation(.default.speed(0.5), value: settingsOpen)
                
            } else {
                TimerView(settingsOpen: $settingsOpen, audioPlayer: $audioPlayer,volume: $volume, progressTime: $progressTime, isRunning: $isRunning, isMuted: $isMuted, soundInitialised: $soundInitialised, timer: $timer)
                    .transition(.ScaleFade)
                    .frame(width: 150)
                    .animation(.default.speed(0.5), value: settingsOpen)
                
            }
        }
        
        .background(.thickMaterial)
        .background(setThemeColor())
    }
    
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
