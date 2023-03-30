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
    
    var body: some View{
        VStack{
            if (titleText != nil){
                Text(titleText ?? "")
                    .font(titleFont)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
            }
            TextField(placeHolderText ?? "", text: $text)
                .frame(maxWidth: .infinity)
                .disabled(disable?.wrappedValue ?? false)
                .padding([.leading, .trailing], 12)
                .background(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.black)
                        .background(
                            (disable?.wrappedValue ?? false ? disableColor : Color.clear)
                            .cornerRadius(5.0)
                        )
                        .frame(height: 50)
                )
            if (errorText != nil){
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
}

struct CustomTextField_Previews: PreviewProvider {
    
    @State static var text = "Esat Gozcu"
    @State static var error = true
    @State static var errorText = "Your name did not matched"

    static var previews: some View {
        CustomTextField(text: $text)
            .setError(errorText: $errorText, error: $error)
            .padding()
    }
}

