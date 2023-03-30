# SwiftUI Custom TextField

This repository developed for SwiftUI textfield component. 

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
@State var errorText = "Your name did not matched"

CustomTextField(text: $text)
                .setError(errorText: $errorText, error: $error)
```

<img width="436" alt="Bottom error" src="https://user-images.githubusercontent.com/35576161/228711460-baddbe3a-7af8-4664-931e-2f8905c97dc4.png">


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

CustomTextField(text: $text).setSecureText(true)
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

