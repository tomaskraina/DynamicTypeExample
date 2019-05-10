# DynamicTypeExample

This application demostrates how to implement [Dynamic Type](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/), scale both preferred and [custom fonts](https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically), and finally and how scaling works for different text styles.

The code also shows the following:
- Overriding trait collection for child view controllers to inject custom `UIContentSizeCategory`: https://stackoverflow.com/questions/43879298/dynamically-mocking-ios-dynamic-type-system-text-size-uicontentsizecategory
- Creating scaled font for specific `UIFont.TextStyle` and `UITraitCollection`
- Observing and hangling `UIContentSizeCategory.didChangeNotification`
- Bug where fonts created with `.largeTitle` are not scaled automatically: http://www.openradar.me/45338369

Useful resources on this topic:

- https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
- https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically
- https://useyourloaf.com/blog/making-space-for-dynamic-type/
- https://useyourloaf.com/blog/using-a-custom-font-with-dynamic-type/
- https://useyourloaf.com/blog/larger-dynamic-type-for-accessibility/
- https://useyourloaf.com/blog/auto-adjusting-fonts-for-dynamic-type/
- https://stackoverflow.com/questions/43879298/dynamically-mocking-ios-dynamic-type-system-text-size-uicontentsizecategory
- https://twitter.com/timcamber/status/864131604108726272
- https://learnui.design/blog/ios-font-size-guidelines.html

## GIF or didn't happen

![DynamicTypeExample](https://github.com/tomaskraina/DynamicTypeExample/raw/master/DynamicTypeExample.gif)

## Requirements

- iOS 11.0+
- Xcode 10.2.1+
- Swift 5+


Contact
-------
Tom Kraina, me@tomkraina.com
