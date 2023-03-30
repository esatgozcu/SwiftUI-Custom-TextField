//
//  CustomTextField.swift
//  CustomTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var titleText: String?
    var titleColor: Color? = .black
    var titleFont: Font?
    var placeHolderText: String?
    var disable: Binding<Bool>?
    var disableColor: Color? = .gray.opacity(0.5)
    var error: Binding<Bool>?
    var errorText: Binding<String>?
    var errorColor: Color? = .red
    var errorFont: Font?
    var trailingImage: Image?
    var trailingImageClick : (() -> Void)?
    
    var body: some View{
        VStack{
            if titleText != nil{
                Text(titleText ?? "")
                    .font(titleFont)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
            }
            HStack(spacing: 0){
                TextField(placeHolderText ?? "", text: $text)
                    .frame(maxWidth: .infinity)
                    .disabled(disable?.wrappedValue ?? false)
                    .padding([.leading, .trailing], 12)
                trailingImage?
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        trailingImageClick?()
                    }
                    .disabled(disable?.wrappedValue ?? false)
            }.background(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(Color.black)
                    .background(
                        (disable?.wrappedValue ?? false ? disableColor : Color.clear)
                        .cornerRadius(5.0)
                    )
                    .frame(height: 50)
            )
            if errorText != nil{
                Text(errorText?.wrappedValue ?? "")
                    .font(errorFont)
                    .foregroundColor(errorColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 15)
            }
        }
    }
}

extension CustomTextField{
    func setTitleText(_ titleText: String?) -> Self{
        var copy = self
        copy.titleText = titleText
        return copy
    }
    func setTitleColor(_ titleColor: Color?) -> Self{
        var copy = self
        copy.titleColor = titleColor
        return copy
    }
    func setTitleFont(_ titleFont: Font?) -> Self{
        var copy = self
        copy.titleFont = titleFont
        return copy
    }
    func setPlaceHolderText(_ placeHolderText: String?) -> Self {
        var copy = self
        copy.placeHolderText = placeHolderText
        return copy
    }
    func setDisable(_ disable: Binding<Bool>?) -> Self{
        var copy = self
        copy.disable = disable
        return copy
    }
    func setDisableColor(_ color: Color?) -> Self{
        var copy = self
        copy.disableColor = color
        return copy
    }
    func setError(errorText: Binding<String>?, error: Binding<Bool>?) -> Self {
        var copy = self
        copy.error = error
        copy.errorText = errorText
        return copy
    }
    func setErrorColor(_ color: Color?) -> Self{
        var copy = self
        copy.errorColor = color
        return copy
    }
    func setErrorFont(_ errorFont: Font?) -> Self{
        var copy = self
        copy.errorFont = errorFont
        return copy
    }
    func setTrailingImage(_ image: Image?, click: @escaping (()->Void)) -> Self{
        var copy = self
        copy.trailingImage = image
        copy.trailingImageClick = click
        return copy
    }
}
