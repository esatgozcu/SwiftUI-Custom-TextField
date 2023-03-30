//
//  CustomTextField.swift
//  CustomTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

@available(iOS 13.0, *)
public struct CustomTextField: View {
    
    var text: Binding<String>
    var textColor: Color?
    var titleText: String?
    var titleColor: Color?
    var titleFont: Font?
    var placeHolderText: String?
    var placeHolderTextColor: Color?
    var disable: Binding<Bool>?
    var disableColor: Color?
    var error: Binding<Bool>?
    var errorText: Binding<String>?
    var errorTextColor: Color?
    var errorFont: Font?
    @State var trailingImage : Image?
    var trailingImageClick: (() -> Void)?
    @State var secureText = false
    var isSecureText: Bool = false
    var secureTextImageOpen : Image?
    var secureTextImageClose : Image?
    var maxCount: Int?
    var truncationMode: Text.TruncationMode?
    var borderColor: Color?
    
    public init(text: Binding<String>,
                textColor: Color? = .black,
                titleText: String? = nil,
                titleColor: Color? = .black,
                titleFont: Font? = nil,
                placeHolderText: String? = nil,
                placeHolderTextColor: Color? = nil,
                disable: Binding<Bool>? = nil,
                disableColor: Color? = .gray.opacity(0.5),
                error: Binding<Bool>? = nil,
                errorText: Binding<String>? = nil,
                errorTextColor: Color? = .red,
                errorFont: Font? = nil,
                trailingImage: Image? = nil,
                trailingImageClick: (() -> Void)? = nil,
                secureText: Bool = false,
                isSecureText: Bool = false,
                secureTextImageOpen: Image? = Image(systemName: "eye.fill"),
                secureTextImageClose: Image? = Image(systemName: "eye.slash.fill"),
                maxCount: Int = 0,
                truncationMode: Text.TruncationMode? = nil,
                borderColor: Color? = nil
    ) {
        self.text = text
        self.textColor = textColor
        self.titleText = titleText
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.placeHolderText = placeHolderText
        self.placeHolderTextColor = placeHolderTextColor
        self.disable = disable
        self.disableColor = disableColor
        self.error = error
        self.errorText = errorText
        self.errorTextColor = errorTextColor
        self.errorFont = errorFont
        self.trailingImage = trailingImage
        self.trailingImageClick = trailingImageClick
        self.secureText = secureText
        self.isSecureText = isSecureText
        self.secureTextImageOpen = secureTextImageOpen
        self.secureTextImageClose = secureTextImageClose
        self.maxCount = maxCount
        self.truncationMode = truncationMode
        self.borderColor = borderColor
    }
    
    public var body: some View{
        VStack(spacing: 5){
            //Title
            if titleText != nil{
                Text(titleText ?? "")
                    .font(titleFont ?? .callout)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            //TextField
            HStack(spacing: 0){
                secureAnyView()
                    .placeholder(when: text.wrappedValue.isEmpty, placeholder: {
                        Text(placeHolderText ?? "").foregroundColor(placeHolderTextColor)
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(textColor)
                    .disabled(disable?.wrappedValue ?? false)
                    .padding([.leading, .trailing], 12)
                    .onReceive(text.wrappedValue.publisher.collect()) {
                        let s = String($0.prefix(maxCount ?? 0))
                        if text.wrappedValue != s && (maxCount != 0){
                            text.wrappedValue = s
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
            return error?.wrappedValue ?? false ? errorTextColor! : Color.black
        }
    }
}
@available(iOS 13.0, *)
extension CustomTextField{
    public func setTextColor(_ color: Color?) -> Self{
        var copy = self
        copy.textColor = color
        return copy
    }
    public func setTitleText(_ titleText: String?) -> Self{
        var copy = self
        copy.titleText = titleText
        return copy
    }
    public func setTitleColor(_ titleColor: Color?) -> Self{
        var copy = self
        copy.titleColor = titleColor
        return copy
    }
    public func setTitleFont(_ titleFont: Font?) -> Self{
        var copy = self
        copy.titleFont = titleFont
        return copy
    }
    public func setPlaceHolderText(_ placeHolderText: String?) -> Self {
        var copy = self
        copy.placeHolderText = placeHolderText
        return copy
    }
    public func setPlaceHolderTextColor(_ color: Color?) -> Self{
        var copy = self
        copy.placeHolderTextColor = color
        return copy
    }
    public func setDisable(_ disable: Binding<Bool>?) -> Self{
        var copy = self
        copy.disable = disable
        return copy
    }
    public func setDisableColor(_ color: Color?) -> Self{
        var copy = self
        copy.disableColor = color
        return copy
    }
    public func setError(errorText: Binding<String>?, error: Binding<Bool>?) -> Self {
        var copy = self
        copy.error = error
        copy.errorText = errorText
        return copy
    }
    public func setErrorTextColor(_ color: Color?) -> Self{
        var copy = self
        copy.errorTextColor = color
        return copy
    }
    public func setErrorFont(_ errorFont: Font?) -> Self{
        var copy = self
        copy.errorFont = errorFont
        return copy
    }
    public func setTrailingImage(_ image: Image?, click: @escaping (()->Void)) -> Self{
        var copy = self
        copy._trailingImage = State(initialValue: image ?? Image(systemName: "xmark.octagon"))
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
    public func setTruncateMode(_ mode: Text.TruncationMode?) -> Self{
        var copy = self
        copy.truncationMode = mode ?? .tail
        return copy
    }
    public func setBorderColor(_ color: Color?) -> Self{
        var copy = self
        copy.borderColor = color
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