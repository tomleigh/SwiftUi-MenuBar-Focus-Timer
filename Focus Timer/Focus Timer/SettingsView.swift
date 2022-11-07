//
//  SettingsView.swift
//  Focus Timer
//
//  Created by Tom Leigh on 13/10/2022.
//

import SwiftUI
import AVKit

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
             /// Note: will need to edit sound on the AVPlayer
             
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
