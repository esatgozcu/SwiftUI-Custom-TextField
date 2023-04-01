# SwiftUI Custom TextField

This repository developed with only swiftUI, there is no UIViewRepresentable.

#### Requirements
- iOS 13.0+
- Xcode 13+
- Swift 5+

#### Swift Package Manager

CustomTextfield is available through [Swift Package Manager](https://swift.org/package-manager/). Add CustomTextField as a dependency to your `Package.swift`:

```Swift
.package(url: "https://github.com/esatgozcu/SwiftUI-Custom-TextField", from: "main")
```

## Examples

#### Default

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
```

<img width="436" alt="Default" src="https://user-images.githubusercontent.com/35576161/228702554-e2f74f8f-3f08-4903-a557-1a9bbb827315.png">

#### Title

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
                .setTitleText("Name")
                .setTitleColor(.blue)
                .setTitleFont(.body)
```

<img width="436" alt="Title" src="https://user-images.githubusercontent.com/35576161/228702798-49369fd7-d490-4c8e-86a4-955a93144c26.png">

#### PlaceHolder

```swift
@State var text = ""

CustomTextField(text: $text)
                .setPlaceHolderText("Enter a name")
```

<img width="436" alt="PlaceHolder" src="https://user-images.githubusercontent.com/35576161/228703270-fcd1fbb2-a713-406c-838e-39a346ff4b89.png">

Also if you want you can change placeholder color

```swift
@State var text = ""

CustomTextField(text: $text)
                .setPlaceHolderText("Enter a name")
                .setPlaceHolderTextColor(Color.gray)
```

#### Disable

```swift
@State var text = "Esat Gozcu"
@State var disable = true

CustomTextField(text: $text)
                .setDisable($disable)
                .setDisableColor(Color.gray.opacity(0.2))
```

<img width="436" alt="Disable" src="https://user-images.githubusercontent.com/35576161/228703733-e3acdd34-b7b8-4e63-a768-c08eb85065ff.png">


#### Bottom Error

```swift
@State var text = "Esat Gozcu"
@State var error = true
@State var errorText = "Your name is not matched"

CustomTextField(text: $text)
                .setError(errorText: $errorText, error: $error)
```

<img width="436" alt="Bottom Error" src="https://user-images.githubusercontent.com/35576161/228750294-0ffbb52f-c7ec-47f6-98f7-bd9c54ab3034.png">


#### Trailing Image

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
                .setTrailingImage(Image(systemName: "qrcode"), click: {
                    print("qr image tapped")
                })
```

<img width="436" alt="Trailing Image" src="https://user-images.githubusercontent.com/35576161/228709637-445ed737-8a0f-4985-a6fd-b7e065588cc9.png">

#### Secure Text

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
               .setSecureText(true)
```

<img width="436" alt="Secure Text Close" src="https://user-images.githubusercontent.com/35576161/228730561-5205ed79-3679-4746-8bce-7801a56194c2.png">
<img width="436" alt="Secure Text Open" src="https://user-images.githubusercontent.com/35576161/228730731-ddd7513e-3645-4d49-a4de-b17ee24bcd15.png">

Secure text images can be changed

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
                .setSecureText(true)
                .setSecureTextImages(open : Image(systemName: "eye.fill"),
                                     close: Image(systemName: "eye.slash.fill"))
```

#### Max Count

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
                .setMaxCount(8)
```

<img width="436" alt="Max Count" src="https://user-images.githubusercontent.com/35576161/228733177-d59f53e3-848e-41f9-99c7-0499272f353a.png">

#### Truncation Mode

```swift
@State var text = "esat1feyk23mqjyefycrfk862x78cyk2sy9l0t8rt6c"

CustomTextField(text: $text)
                .setTruncateMode(.middle)
```

<img width="436" alt="Truncation Mode" src="https://user-images.githubusercontent.com/35576161/228734064-981156ab-daba-4ee5-b2ed-c951fc11e476.png">

#### Border Color and Width

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
                .setBorderColor(.orange)
                .setBorderWidth(1.0)
```

<img width="436" alt="Border Color" src="https://user-images.githubusercontent.com/35576161/228738468-6ef33d39-79b5-4040-a890-48c97bce218a.png">

#### Text Color

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
                .setTextColor(.blue)
```

<img width="436" alt="Text Color" src="https://user-images.githubusercontent.com/35576161/228739233-9d3c63e1-d671-448a-bfbe-eb264e9c42a4.png">

#### Background Color

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
            .setBackgroundColor(Color.black)
            .setTextColor(Color.white)
```

<img width="436" alt="Background Color" src="https://user-images.githubusercontent.com/35576161/229054807-49ac1499-a434-4ef4-8f7e-5d048dbdafda.png">

#### Corner Radius

```swift
@State var text = "Esat Gozcu"

CustomTextField(text: $text)
            .setCornerRadius(20.0)
```

<img width="436" alt="Corner Radius" src="https://user-images.githubusercontent.com/35576161/229308516-32bd5bef-57da-4b41-b84c-551934f1f86a.png">
