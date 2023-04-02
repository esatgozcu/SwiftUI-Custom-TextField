//
//  EGTextField.swift
//  EGTextField
//
//  Created by Esat Gözcü on 2023/03/30.
//

import SwiftUI

@available(iOS 13.0, *)
public struct EGTextField: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var trailingImage : Image?
    @State private var secureText = false
    private var text: Binding<String>
    private var disable: Binding<Bool>?
    private var error: Binding<Bool>?
    private var errorText: Binding<String>?
    private var isSecureText: Bool = false
    private var titleText: String?
    private var placeHolderText: String = ""
    private var trailingImageClick: (() -> Void)?
    private var secureTextImageOpen : Image? = Image(systemName: "eye.fill")
    private var secureTextImageClose : Image? = Image(systemName: "eye.slash.fill")
    private var maxCount: Int?
    private var truncationMode: Text.TruncationMode = Text.TruncationMode.tail
    //Text Color
    private var defaultTextColor = EGTextFieldConfig.shared.defaultTextColor
    private var darkModeTextColor = EGTextFieldConfig.shared.darkModeTextColor
    //Title Color
    private var defaultTitleColor = EGTextFieldConfig.shared.defaultTitleColor
    private var darkModeTitleColor = EGTextFieldConfig.shared.darkModeTitleColor
    //PlaceHolder Text Color
    private var defaultPlaceHolderTextColor = EGTextFieldConfig.shared.defaultPlaceHolderTextColor
    private var darkModePlaceHolderTextColor = EGTextFieldConfig.shared.darkModePlaceHolderTextColor
    //Disable Color
    private var defaultDisableColor = EGTextFieldConfig.shared.defaultDisableColor
    private var darkModeDisableColor = EGTextFieldConfig.shared.darkModeDisableColor
    //Background Color
    private var defaultBackgroundColor = EGTextFieldConfig.shared.defaultBackgroundColor
    private var darkModeBackgroundColor = EGTextFieldConfig.shared.darkModeBackgroundColor
    //Error Text Color
    private var defaultErrorTextColor = EGTextFieldConfig.shared.defaultErrorTextColor
    private var darkModeErrorTextColor = EGTextFieldConfig.shared.darkModeErrorTextColor
    //Border Color
    private var defaultBorderColor = EGTextFieldConfig.shared.defaultBorderColor
    private var darkModeBorderColor = EGTextFieldConfig.shared.darkModeBorderColor
    //Default
    private var titleFont = EGTextFieldConfig.shared.titleFont
    private var errorFont = EGTextFieldConfig.shared.errorFont
    private var borderWidth = EGTextFieldConfig.shared.borderWidth
    private var cornerRadius = EGTextFieldConfig.shared.cornerRadius
    private var borderType = EGTextFieldConfig.shared.borderType
    private var disableAutocorrection = EGTextFieldConfig.shared.disableAutocorrection

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
            VStack(spacing: 0){
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
                        .padding([.leading, .trailing], borderType == .square ? 12 : 1)
                        .disableAutocorrection(disableAutocorrection)
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
                    RoundedRectangle(cornerRadius: getCornerRadius())
                        .stroke(getBorderColor(), lineWidth: getBorderWidth())
                        .background(getBackgroundColor().cornerRadius(getCornerRadius()))
                )
                //Bottom Line
                if borderType == .line{
                    Rectangle()
                        .frame(height: borderWidth)
                        .foregroundColor(getBorderColor())
                }
            }
            //Bottom text
            if let error = error?.wrappedValue{
                if error{
                    Text(errorText?.wrappedValue ?? "")
                        .font(errorFont)
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
            return colorScheme == .light ? defaultBorderColor : darkModeBorderColor
        }
    }
    func getBackgroundColor() -> Color{
        if disable?.wrappedValue ?? false{
            return colorScheme == .light ? defaultDisableColor : darkModeDisableColor
        }
        else{
            return colorScheme == .light ? defaultBackgroundColor : darkModeBackgroundColor
        }
    }
    func getTextColor() -> Color{
        return colorScheme == .light ? defaultTextColor : darkModeTextColor
    }
    func getErrorTextColor() -> Color{
        return colorScheme == .light ? defaultErrorTextColor : darkModeErrorTextColor
    }
    func getPlaceHolderTextColor() -> Color{
        return colorScheme == .light ? defaultPlaceHolderTextColor : darkModePlaceHolderTextColor
    }
    func getTitleTextColor() -> Color{
        return colorScheme == .light ? defaultTitleColor : darkModeTitleColor
    }
    func getBorderWidth() -> CGFloat{
        return borderType == .square ? borderWidth : 0.0
    }
    func getCornerRadius() -> CGFloat{
        return borderType == .square ? cornerRadius : 0.0
    }
}

@available(iOS 13.0, *)
extension EGTextField{
    public func setTextColor(_ color: Color) -> Self{
        var copy = self
        copy.defaultTextColor = color
        return copy
    }
    public func setDarkModeTextColor(_ color: Color) -> Self{
        var copy = self
        copy.darkModeTextColor = color
        return copy
    }
    public func setTitleText(_ titleText: String) -> Self{
        var copy = self
        copy.titleText = titleText
        return copy
    }
    public func setTitleColor(_ titleColor: Color) -> Self{
        var copy = self
        copy.defaultTitleColor = titleColor
        return copy
    }
    public func setDarkModeTitleColor(_ titleColor: Color) -> Self{
        var copy = self
        copy.darkModeTitleColor = titleColor
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
        copy.defaultPlaceHolderTextColor = color
        return copy
    }
    public func setDarkModePlaceHolderTextColor(_ color: Color) -> Self{
        var copy = self
        copy.darkModePlaceHolderTextColor = color
        return copy
    }
    public func setDisable(_ disable: Binding<Bool>) -> Self{
        var copy = self
        copy.disable = disable
        return copy
    }
    public func setDisableColor(_ color: Color) -> Self{
        var copy = self
        copy.defaultDisableColor = color
        return copy
    }
    public func setDarkModeDisableColor(_ color: Color) -> Self{
        var copy = self
        copy.darkModeDisableColor = color
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
        copy.defaultErrorTextColor = color
        return copy
    }
    public func setDarkModeErrorTextColor(_ color: Color) -> Self{
        var copy = self
        copy.darkModeErrorTextColor = color
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
        copy.defaultBorderColor = color
        return copy
    }
    public func setDarkModeBorderColor(_ color: Color) -> Self{
        var copy = self
        copy.darkModeBorderColor = color
        return copy
    }
    public func setBorderWidth(_ width: CGFloat) -> Self{
        var copy = self
        copy.borderWidth = width
        return copy
    }
    public func setBackgroundColor(_ color: Color) -> Self{
        var copy = self
        copy.defaultBackgroundColor = color
        return copy
    }
    public func setDarkModeBackgroundColor(_ color: Color) -> Self{
        var copy = self
        copy.darkModeBackgroundColor = color
        return copy
    }
    public func setCornerRadius(_ radius: CGFloat) -> Self{
        var copy = self
        copy.cornerRadius = radius
        return copy
    }
    public func setBorderType(_ type: BorderType) -> Self{
        var copy = self
        copy.borderType = type
        return copy
    }
    public func setDisableAutoCorrection(_ disable: Bool) -> Self{
        var copy = self
        copy.disableAutocorrection = disable
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
