//
//  EGTextFieldConfig.swift
//  CustomEdittext
//
//  Created by Esat Gözcü on 2023/04/03.
//

import SwiftUI

@available(iOS 13.0, *)
public class EGTextFieldConfig: ObservableObject{
    static var shared = EGTextFieldConfig()
    private init(){}
    
    //Text Color
    @Published var defaultTextColor : Color = .black
    @Published var darkModeTextColor : Color = .white
    //Title Color
    @Published var defaultTitleColor : Color = .black
    @Published var darkModeTitleColor : Color = .white
    //PlaceHolder Text Color
    @Published var defaultPlaceHolderTextColor : Color = .gray.opacity(0.8)
    @Published var darkModePlaceHolderTextColor : Color = .white.opacity(0.3)
    //Disable Color
    @Published var defaultDisableColor : Color = .gray.opacity(0.5)
    @Published var darkModeDisableColor : Color = .gray.opacity(0.3)
    //Background Color
    @Published var defaultBackgroundColor : Color = .white
    @Published var darkModeBackgroundColor : Color = .black
    //Error Text Color
    @Published var defaultErrorTextColor : Color = .red
    @Published var darkModeErrorTextColor : Color = .red
    //Border Color
    @Published var defaultBorderColor : Color = .black
    @Published var darkModeBorderColor : Color = .white
}
