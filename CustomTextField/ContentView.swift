//
//  ContentView.swift
//  CustomTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = "Esat Gozcu"

    var body: some View {
        VStack {
            CustomTextField(text: $text)
                .setSecureText(true)
                .setSecureTextImages(open: Image(systemName: "eye.fill"),
                                     close: Image(systemName: "eye.slash.fill"))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
