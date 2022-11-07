//
//  SettingsView.swift
//  Focus Timer
//
//  Created by Tom Leigh on 13/10/2022.
//

import SwiftUI
import AVKit

/// View of the settings window that appears when the Cog icon is pressed
struct SettingsView: View {
    @Binding var settingsOpen: Bool
    @Binding var audioPlayer: AVAudioPlayer!
    @Binding var volume: Double
    @Binding var colourTheme: String
    @Binding var soundscape: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            Divider()
            Text("Volume")
            // Set the sound volume
            Slider(
                value: $volume,
                in: 0.1...1.0,
                onEditingChanged: { editing in
                    audioPlayer.setVolume((Float)(volume), fadeDuration: 0)
                }
            )
            Divider()
            
            /*
             /// Possible future update with different soundscapes
             /// Note: will need to edit the sound on the AVPlayer in TimerView .onAppear
             
            Picker(selection: $soundscape, label: Text("Sound:")) {
                Text("Rain").tag("Rain")
                Text("Ocean").tag("Ocean")
                Text("Wind").tag("Wind")
                Text("Storm").tag("Storm")
                Text("Cafe").tag("Cafe")
                Text("City").tag("City")
            }.pickerStyle(RadioGroupPickerStyle())
            
            Divider()
            */
            
            // Change the menu colour theme
            Picker(selection: $colourTheme, label: Text("Theme:")) {
                Text("Default").tag("Default")
                Text("Blue").tag("Blue")
                Text("Green").tag("Green")
                Text("Orange").tag("Orange")
                Text("Pink").tag("Pink")
                Text("Red").tag("Red")
                Text("Yellow").tag("Yellow")
            }.pickerStyle(RadioGroupPickerStyle())
            
            Divider()
            
            // quit the application
            Button(action: {
                NSApplication.shared.terminate(nil)
            }, label: {
                Label("Quit", systemImage: "xmark.circle.fill")
                    .labelStyle(.titleAndIcon)
                    .frame(maxWidth: .infinity)
            })
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 8)
        
    }
        
}
