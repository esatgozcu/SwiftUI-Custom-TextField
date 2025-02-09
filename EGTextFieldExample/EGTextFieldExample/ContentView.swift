//
//  ContentView.swift
//  EGTextFieldExample
//
//  Created by Esat Gözcü on 9.02.2025.
//

import SwiftUI
import CustomTextField

struct ContentView: View {
    @State private var password: String = "Test FocusState"
    @FocusState private var isPasswordFieldFocused: Bool
    
    var body: some View {
        VStack {
            EGTextField(text: $password)
                .setSecureText(true)
                .setBorderColor(isPasswordFieldFocused ? .gray : .gray.opacity(0.1))
                .focused($isPasswordFieldFocused)
            Button("Close Keyboard") {
                isPasswordFieldFocused = false
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
