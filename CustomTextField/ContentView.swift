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
                .setBorderColor(.orange)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
