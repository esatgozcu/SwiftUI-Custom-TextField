//
//  ContentView.swift
//  CustomTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = "Esat Gozcu"
    @State var error = true
    @State var errorText = "Your name is not matched"

    var body: some View {
        VStack {
            CustomTextField(text: $text)
                .setError(errorText: $errorText, error: $error)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
