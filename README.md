# DynamicTypeExample

This application demostrates how to scale both preferend and custom fonts and how scaling works for different text styles.

The code also shows the following:
- Overriding trait collection for child view controllers to inject custom `UIContentSizeCategory`: https://stackoverflow.com/questions/43879298/dynamically-mocking-ios-dynamic-type-system-text-size-uicontentsizecategory
- Creating scaled font for specific `UIFont.TextStyle` and `UITraitCollection`
- Observing and hangling `UIContentSizeCategory.didChangeNotification`
- Bug where fonts created with `.largeTitle` are not scaled automatically: http://www.openradar.me/45338369

## GIF or didn't happen

![DynamicTypeExample](https://github.com/tomaskraina/DynamicTypeExample/raw/master/DynamicTypeExample.gif)

## Requirements

- iOS 11.0+
- Xcode 10.2.1+
- Swift 5+


Contact
-------
Tom Kraina, me@tomkraina.com
