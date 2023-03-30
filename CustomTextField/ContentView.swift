//
//  ContentView.swift
//  CustomTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = "esat1feyk23mqjyefycrfk862x78cyk2sy9l0t8rt6c"

    var body: some View {
        VStack {
            CustomTextField(text: $text)
                .setTruncateMode(.middle)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
