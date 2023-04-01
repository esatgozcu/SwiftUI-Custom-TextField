//
//  CustomTextField.swift
//  CustomTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

@available(iOS 13.0, *)
public struct CustomTextField: View {

    public var text: Binding<String>
    public var disable: Binding<Bool>?
    public var error: Binding<Bool>?
    public var errorText: Binding<String>?
    @State public var trailingImage : Image?
    @State public var secureText = false

    public var textColor: Color? = .black
    public var titleText: String?
    public var titleColor: Color? = .black
    public var titleFont: Font? = .callout
    public var placeHolderText: String = ""
    public var placeHolderTextColor: Color? = .gray.opacity(0.8)
    public var disableColor: Color? = .gray.opacity(0.5)
    public var errorTextColor: Color = .red
    public var errorFont: Font? = .footnote
    public var trailingImageClick: (() -> Void)?
    public var isSecureText: Bool = false
    public var secureTextImageOpen : Image? = Image(systemName: "eye.fill")
    public var secureTextImageClose : Image? = Image(systemName: "eye.slash.fill")
    public var maxCount: Int?
    public var truncationMode: Text.TruncationMode = Text.TruncationMode.tail
    public var borderColor: Color? = .black
    public var borderWidth: CGFloat = 1.0
    public var backgroundColor: Color? = .clear
    public var cornerRadius : CGFloat = 5.0
    
    init(text: Binding<String>) {
        self.text = text
    }
    
    public var body: some View{
        VStack(spacing: 5){
            //Title
            if let titleText{
                Text(titleText)
                    .font(titleFont)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            //TextField
            HStack(spacing: 0){
                secureAnyView()
                    .placeholder(when: text.wrappedValue.isEmpty, placeholder: {
                        Text(placeHolderText).foregroundColor(placeHolderTextColor)
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(textColor)
                    .disabled(disable?.wrappedValue ?? false)
                    .padding([.leading, .trailing], 12)
                    .onReceive(text.wrappedValue.publisher.collect()) {
                        if let maxCount{
                            let s = String($0.prefix(maxCount))
                            if text.wrappedValue != s && (maxCount != 0){
                                text.wrappedValue = s
                            }
                        }
                    }
                    .truncationMode(truncationMode)
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
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(getBorderColor(), lineWidth: borderWidth)
                    .background(
                        (disable?.wrappedValue ?? false ? disableColor : backgroundColor)?.cornerRadius(cornerRadius)
                    )
            )
            //Bottom text
            if let error = error?.wrappedValue{
                if error{
                    Text(errorText?.wrappedValue ?? "")
                        .font(errorFont ?? .footnote)
                        .foregroundColor(errorTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    
    func secureAnyView() -> AnyView{
        if !secureText{
            return AnyView(TextField("", text: text))
        }
        else{
            return AnyView(SecureField("", text: text))
        }
    }
    
    func getBorderColor() -> Color{
        //If you set border color error will not be active
        // border color is primary.
        if let borderColor{
            return borderColor
        }
        else{
            return error?.wrappedValue ?? false ? errorTextColor : Color.black
        }
    }
}
@available(iOS 13.0, *)
extension CustomTextField{
    public func setTextColor(_ color: Color) -> Self{
        var copy = self
        copy.textColor = color
        return copy
    }
    public func setTitleText(_ titleText: String) -> Self{
        var copy = self
        copy.titleText = titleText
        return copy
    }
    public func setTitleColor(_ titleColor: Color) -> Self{
        var copy = self
        copy.titleColor = titleColor
        return copy
    }
    public func setTitleFont(_ titleFont: Font) -> Self{
        var copy = self
        copy.titleFont = titleFont
        return copy
    }
    public func setPlaceHolderText(_ placeHolderText: String) -> Self {
        var copy = self
        copy.placeHolderText = placeHolderText
        return copy
    }
    public func setPlaceHolderTextColor(_ color: Color) -> Self{
        var copy = self
        copy.placeHolderTextColor = color
        return copy
    }
    public func setDisable(_ disable: Binding<Bool>) -> Self{
        var copy = self
        copy.disable = disable
        return copy
    }
    public func setDisableColor(_ color: Color) -> Self{
        var copy = self
        copy.disableColor = color
        return copy
    }
    public func setError(errorText: Binding<String>, error: Binding<Bool>) -> Self {
        var copy = self
        copy.error = error
        copy.errorText = errorText
        return copy
    }
    public func setErrorTextColor(_ color: Color) -> Self{
        var copy = self
        copy.errorTextColor = color
        return copy
    }
    public func setErrorFont(_ errorFont: Font) -> Self{
        var copy = self
        copy.errorFont = errorFont
        return copy
    }
    public func setTrailingImage(_ image: Image, click: @escaping (()->Void)) -> Self{
        var copy = self
        copy._trailingImage = State(initialValue: image)
        copy.trailingImageClick = click
        return copy
    }
    public func setSecureText(_ secure: Bool) -> Self{
        var copy = self
        copy._secureText = State(initialValue: secure)
        if secure{
            copy._trailingImage = State(initialValue: copy.secureTextImageClose)
        }
        copy.isSecureText = secure
        return copy
    }
    public func setSecureTextImages(open: Image, close: Image) -> Self{
        var copy = self
        copy.secureTextImageOpen = open
        copy.secureTextImageClose = close
        copy._trailingImage = State(initialValue: copy.secureTextImageClose)
        return copy
    }
    public func setMaxCount(_ count: Int) -> Self{
        var copy = self
        copy.maxCount = count
        return copy
    }
    public func setTruncateMode(_ mode: Text.TruncationMode) -> Self{
        var copy = self
        copy.truncationMode = mode
        return copy
    }
    public func setBorderColor(_ color: Color) -> Self{
        var copy = self
        copy.borderColor = color
        return copy
    }
    public func setBorderWidth(_ width: CGFloat) -> Self{
        var copy = self
        copy.borderWidth = width
        return copy
    }
    public func setBackgroundColor(_ color: Color) -> Self{
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    public func setCornerRadius(_ radius: CGFloat) -> Self{
        var copy = self
        copy.cornerRadius = radius
        return copy
    }
}

@available(iOS 13.0, *)
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
