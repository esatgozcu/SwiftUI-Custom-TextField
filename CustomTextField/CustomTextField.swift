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
    var errorTextColor: Color? = .red
    var errorFont: Font?
    @State var trailingImage : Image?
    var trailingImageClick: (() -> Void)?
    @State var secureText = false
    var isSecureText: Bool = false
    var secureTextImageOpen : Image? = Image(systemName: "eye.fill")
    var secureTextImageClose : Image? = Image(systemName: "eye.slash.fill")
    var maxCount: Int = 0
    var truncationMode: Text.TruncationMode?
    var borderColor: Color?
    
    var body: some View{
        VStack{
            //Title
            if titleText != nil{
                Text(titleText ?? "")
                    .font(titleFont)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
            }
            //TextField
            HStack(spacing: 0){
                secureAnyView()
                    .frame(maxWidth: .infinity)
                    .disabled(disable?.wrappedValue ?? false)
                    .padding([.leading, .trailing], 12)
                    .onReceive(text.publisher.collect()) {
                        let s = String($0.prefix(maxCount))
                        if text != s && (maxCount != 0){
                            text = s
                        }
                    }
                    .truncationMode(truncationMode ?? Text.TruncationMode.tail)
                trailingImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        if !isSecureText{
                            trailingImageClick?()
                        }
                        else{
                            secureText.toggle()
                            trailingImage = secureText ? secureTextImageClose : secureTextImageOpen
                        }
                    }
                    .disabled(disable?.wrappedValue ?? false)
            }.background(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(getBorderColor())
                    .background(
                        (disable?.wrappedValue ?? false ? disableColor : Color.clear)
                        .cornerRadius(5.0)
                    )
                    .frame(height: 50)
            )
            //Bottom text
            if let error = error?.wrappedValue{
                if error{
                    Text(errorText?.wrappedValue ?? "")
                        .font(errorFont)
                        .foregroundColor(errorTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 15)
                }
            }
        }
    }
    
    func secureAnyView() -> AnyView{
        if !secureText{
            return AnyView(TextField(placeHolderText ?? "", text: $text))
        }
        else{
            return AnyView(SecureField(placeHolderText ?? "", text: $text))
        }
    }
    
    func getBorderColor() -> Color{
        //If you set border color error will not be active
        // border color is primary.
        if let borderColor{
            return borderColor
        }
        else{
            return error?.wrappedValue ?? false ? errorTextColor! : Color.black
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
    func setErrorTextColor(_ color: Color?) -> Self{
        var copy = self
        copy.errorTextColor = color
        return copy
    }
    func setErrorFont(_ errorFont: Font?) -> Self{
        var copy = self
        copy.errorFont = errorFont
        return copy
    }
    func setTrailingImage(_ image: Image?, click: @escaping (()->Void)) -> Self{
        var copy = self
        copy._trailingImage = State(initialValue: image ?? Image(systemName: "xmark.octagon"))
        copy.trailingImageClick = click
        return copy
    }
    func setSecureText(_ secure: Bool) -> Self{
        var copy = self
        copy._secureText = State(initialValue: secure)
        if secure{
            copy._trailingImage = State(initialValue: copy.secureTextImageClose)
        }
        copy.isSecureText = secure
        return copy
    }
    func setSecureTextImages(open: Image, close: Image) -> Self{
        var copy = self
        copy.secureTextImageOpen = open
        copy.secureTextImageClose = close
        copy._trailingImage = State(initialValue: copy.secureTextImageClose)
        return copy
    }
    func setMaxCount(_ count: Int) -> Self{
        var copy = self
        copy.maxCount = count
        return copy
    }
    func setTruncateMode(_ mode: Text.TruncationMode?) -> Self{
        var copy = self
        copy.truncationMode = mode ?? .tail
        return copy
    }
    func setBorderColor(_ color: Color?) -> Self{
        var copy = self
        copy.borderColor = color
        return copy
    }
}
