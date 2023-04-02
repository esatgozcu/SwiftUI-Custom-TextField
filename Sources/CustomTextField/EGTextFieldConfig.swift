//
//  EGTextFieldConfig.swift
//  CustomEdittext
//
//  Created by Esat Gözcü on 2023/04/03.
//

import SwiftUI

@available(iOS 13.0, *)
public class EGTextFieldConfig{
    static var shared = EGTextFieldConfig()
    private init(){}
    
    //Text Color
    var defaultTextColor : Color = .black
    var darkModeTextColor : Color = .white
    //Title Color
    var defaultTitleColor : Color = .black
    var darkModeTitleColor : Color = .white
    //PlaceHolder Text Color
    var defaultPlaceHolderTextColor : Color = .gray.opacity(0.8)
    var darkModePlaceHolderTextColor : Color = .white.opacity(0.3)
    //Disable Color
    var defaultDisableColor : Color = .gray.opacity(0.5)
    var darkModeDisableColor : Color = .gray.opacity(0.3)
    //Background Color
    var defaultBackgroundColor : Color = .white
    var darkModeBackgroundColor : Color = .black
    //Error Text Color
    var defaultErrorTextColor : Color = .red
    var darkModeErrorTextColor : Color = .red
    //Border Color
    var defaultBorderColor : Color = .black
    var darkModeBorderColor : Color = .white
    //Default
    var titleFont : Font = .callout
    var errorFont : Font = .footnote
    var borderWidth : CGFloat = 1.0
    var cornerRadius : CGFloat = 5.0
}
