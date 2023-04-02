//
//  EGTextField.swift
//  EGTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

@available(iOS 13.0, *)
public struct EGTextField: View {
    
    @StateObject var vm = EGTextFieldConfig.shared
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var trailingImage : Image?
    @State private var secureText = false
    
    private var text: Binding<String>
    private var disable: Binding<Bool>?
    private var error: Binding<Bool>?
    private var errorText: Binding<String>?
    private var titleText: String?
    private var titleFont: Font? = .callout
    private var placeHolderText: String = ""
    private var errorFont: Font? = .footnote
    private var trailingImageClick: (() -> Void)?
    private var isSecureText: Bool = false
    private var secureTextImageOpen : Image? = Image(systemName: "eye.fill")
    private var secureTextImageClose : Image? = Image(systemName: "eye.slash.fill")
    private var maxCount: Int?
    private var truncationMode: Text.TruncationMode = Text.TruncationMode.tail
    private var borderWidth: CGFloat = 1.0
    private var cornerRadius : CGFloat = 5.0
    
    public init(text: Binding<String>) {
        self.text = text
    }
    
    public var body: some View{
        VStack(spacing: 5){
            //Title
            if let titleText{
                Text(titleText)
                    .font(titleFont)
                    .foregroundColor(getTitleTextColor())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            //TextField
            HStack(spacing: 0){
                secureAnyView()
                    .placeholder(when: text.wrappedValue.isEmpty, placeholder: {
                        Text(placeHolderText).foregroundColor(getPlaceHolderTextColor())
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(getTextColor())
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
                    .background(Color.clear)
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
                    .background(getBackgroundColor().cornerRadius(cornerRadius))
            )
            //Bottom text
            if let error = error?.wrappedValue{
                if error{
                    Text(errorText?.wrappedValue ?? "")
                        .font(errorFont ?? .footnote)
                        .foregroundColor(getErrorTextColor())
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
        if error?.wrappedValue ?? false {
            return getErrorTextColor()
        }
        else{
            return colorScheme == .light ? vm.defaultBorderColor : vm.darkModeBorderColor
        }
    }
    func getBackgroundColor() -> Color{
        if disable?.wrappedValue ?? false{
            return colorScheme == .light ? vm.defaultDisableColor : vm.darkModeDisableColor
        }
        else{
            return colorScheme == .light ? vm.defaultBackgroundColor : vm.darkModeBackgroundColor
        }
    }
    func getTextColor() -> Color{
        return colorScheme == .light ? vm.defaultTextColor : vm.darkModeTextColor
    }
    func getErrorTextColor() -> Color{
        return colorScheme == .light ? vm.defaultErrorTextColor : vm.darkModeErrorTextColor
    }
    func getPlaceHolderTextColor() -> Color{
        return colorScheme == .light ? vm.defaultPlaceHolderTextColor : vm.darkModePlaceHolderTextColor
    }
    func getTitleTextColor() -> Color{
        return colorScheme == .light ? vm.defaultTitleColor : vm.darkModeTitleColor
    }
}

@available(iOS 13.0, *)
extension EGTextField{
    public func setTextColor(_ color: Color) -> Self{
        let copy = self
        copy.vm.defaultTextColor = color
        return copy
    }
    public func setTitleText(_ titleText: String) -> Self{
        var copy = self
        copy.titleText = titleText
        return copy
    }
    public func setTitleColor(_ titleColor: Color) -> Self{
        let copy = self
        copy.vm.defaultTitleColor = titleColor
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
        let copy = self
        copy.vm.defaultPlaceHolderTextColor = color
        return copy
    }
    public func setDisable(_ disable: Binding<Bool>) -> Self{
        var copy = self
        copy.disable = disable
        return copy
    }
    public func setDisableColor(_ color: Color) -> Self{
        let copy = self
        copy.vm.defaultDisableColor = color
        return copy
    }
    public func setError(errorText: Binding<String>, error: Binding<Bool>) -> Self {
        var copy = self
        copy.error = error
        copy.errorText = errorText
        return copy
    }
    public func setErrorTextColor(_ color: Color) -> Self{
        let copy = self
        copy.vm.defaultErrorTextColor = color
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
        let copy = self
        copy.vm.defaultBorderColor = color
        return copy
    }
    public func setBorderWidth(_ width: CGFloat) -> Self{
        var copy = self
        copy.borderWidth = width
        return copy
    }
    public func setBackgroundColor(_ color: Color) -> Self{
        let copy = self
        copy.vm.defaultBackgroundColor = color
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
