//
//  TitleBar.swift
//  Focus Timer
//
//  Created by Tom Leigh on 14/10/2022.
//

import SwiftUI

struct TitleBar: View {
    @Binding var settingsOpen: Bool

    var body: some View {
        HStack(spacing: 20){
            HStack(spacing: 4) {
                Image(systemName: "timer")
                Text("Focus Timer")
            }
            
            Button(action: {
                if(settingsOpen) {
                    withAnimation {
                        settingsOpen.toggle()
                    }
                }
                else {
                    withAnimation {
                        settingsOpen.toggle()
                    }
                }
            }) {
                Label("Toggle", systemImage: settingsOpen ? "chevron.backward.circle.fill" : "gearshape.fill")
                    .labelStyle(.iconOnly)
            }
            .buttonStyle(.plain)
        }
    }
}
