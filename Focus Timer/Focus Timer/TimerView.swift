//
//  TimerView.swift
//  Focus Timer
//
//  Created by Tom Leigh on 13/10/2022.
//

import SwiftUI
import AVKit

/// The main timer view for the menu bar window
struct TimerView: View {
    @Binding var settingsOpen: Bool
    @Binding var audioPlayer: AVAudioPlayer!
    @Binding var volume: Double
    @Binding var progressTime: Int
    @Binding var isRunning: Bool
    @Binding var isMuted: Bool
    @Binding var soundInitialised: Bool
    
    @Binding var timer: Timer?
    
    // Computed properties to get the progressTime in hh:mm:ss format
    var hours: Int { progressTime / 3600 }
    var minutes: Int { (progressTime % 3600) / 60 }
    var seconds: Int { progressTime % 60 }
    

    
    var body: some View {
        VStack(spacing: 0) {
            // Displays the timer in HH:MM:SS format
            HStack(spacing: 0) {
                StopwatchUnitView(timeUnit: hours)
                Text(":")
                StopwatchUnitView(timeUnit: minutes)
                Text(":")
                StopwatchUnitView(timeUnit: seconds)
            }
            .padding(.bottom, -4)
            
            Divider()
                .padding(.vertical, 10)

            
            HStack {
                // Pause / Play button
                Button(action: {
                    // Pause or Resume timer
                    if isRunning {
                        timer?.invalidate()
                        self.audioPlayer.pause()
                    } else {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            progressTime += 1
                        })
                        if(!isMuted) {
                            // Only play sound when resuming if not muted
                            audioPlayer.play()
                        }
                    }
                    isRunning.toggle()
                    
                }, label: {
                    if(progressTime == 0 && isRunning == false) {
                        Label("Start", systemImage: "play.fill")
                            .labelStyle(.iconOnly)
                            .frame(maxWidth: .infinity)
                    }
                    else {
                        Label(isRunning ? "Pause" : "Resume", systemImage: isRunning ? "pause.fill" : "play.fill")
                            .labelStyle(.iconOnly)
                            .frame(maxWidth: .infinity)
                    }
                })
                
                // Restart timer button
                Button(action: {
                    timer?.invalidate()
                    progressTime = 0
                    isRunning = false
                    audioPlayer.pause()
                    
                }, label: {
                    Label("Restart", systemImage: "arrow.counterclockwise")
                        .labelStyle(.iconOnly)
                        .frame(maxWidth: .infinity)
                })
                

                // Mute / Unmute audio
                Button(action: {
                    if(isMuted && isRunning) {
                        audioPlayer.play()
                    }
                    else {
                        audioPlayer.pause()
                    }
                    isMuted.toggle()
                    
                }, label: {
                    Label(isMuted ? "Unmute" : "Mute", systemImage: isMuted ? "speaker.slash.fill" : "speaker.wave.3.fill")
                        .labelStyle(.iconOnly)
                        .frame(maxWidth: .infinity)
                })
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 5)
        
        // AVAudioPlayer must be initialised - but only on the first view of the window
        .onAppear {
            if(!soundInitialised) {
                let sound = Bundle.main.path(forResource: "rain-sound", ofType: "mp3")
                audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                audioPlayer.numberOfLoops = -1
                audioPlayer.setVolume((Float)(volume), fadeDuration: 0)
                soundInitialised = true
            }
        }
    }
}

/// Utility function to display each unit (hours/minutes/seconds) as two digits
/// Source: https://medium.com/geekculture/build-a-stopwatch-in-just-3-steps-using-swiftui-778c327d214b
struct StopwatchUnitView: View {
    var timeUnit: Int

    // Time unit expressed as String.
    // Includes "0" as prefix if this is less than 10.
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        VStack {
            HStack(spacing: 2) {
                Text(timeUnitStr.substring(index: 0))
                    .font(.system(size: 32))
                    .frame(width: 20)
                Text(timeUnitStr.substring(index: 1))
                    .font(.system(size: 32))
                    .frame(width: 20)
            }
        }
    }
}

/// Utility function to get the character at a given index
extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}
