//
//  ContainerViewController.swift
//  DynamicType
//
//  Created by Tom Kraina on 09/05/2019.
//  Copyright © 2019 Tom Kraina. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sizeCategoryLabel: UILabel!
    @IBOutlet weak var customFontSwitch: UISwitch!
    @IBOutlet weak var customFontLabel: UILabel!

    // MARK: - Properties

    /// Change to the font you want to scale
    private lazy var customFont = UIFont.systemFont(ofSize: 15.0, weight: .light)

    /// All available content size categories, copied from UIKit documentation
    private lazy var sizes: [UIContentSizeCategory] = [
        .unspecified,
        .extraSmall,
        .small,
        .medium,
        .large,
        .extraLarge,
        .extraExtraLarge,
        .extraExtraExtraLarge,
        // Accessibility sizes
        .accessibilityMedium,
        .accessibilityLarge,
        .accessibilityExtraLarge,
        .accessibilityExtraExtraLarge,
        .accessibilityExtraExtraExtraLarge,
    ]

    private var selectedSizeCategory: UIContentSizeCategory! {
        didSet {
            self.sizeCategoryLabel.text = self.selectedSizeCategory.description
            self.slider.value = Float(sizes.firstIndex(of: self.selectedSizeCategory) ?? 0)
            self.updateChildSizeCatagory()
        }
    }

    private var childViewController: TextStylesViewController {
        return self.children[0] as! TextStylesViewController
    }

    // MARK: - UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.slider.maximumValue = Float(self.sizes.count - 1)
        self.selectedSizeCategory = self.traitCollection.preferredContentSizeCategory
        self.updateChildFont()

        // To monitor changes in UIContentSizeCategory you can either:
        // - observe the UIContentSizeCategory.didChangeNotification notification
        // - override UIViewController.traitCollectionDidChange(_:) method (see TextStylesViewController)
        NotificationCenter.default.addObserver(self, selector: #selector(ContainerViewController.contentSizeCategoryDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    // MARK: - IBAction

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sizeIndex = Int(round(sender.value))
        self.selectedSizeCategory = self.sizes[sizeIndex]
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        self.updateChildFont()
    }

    // MARK: - Notifications

    /// Handles UIContentSizeCategory.didChangeNotification
    ///
    /// This method is called when the prefered content size category is changed by:
    /// - Changing Font Size in Accessibility Inspector (when run on simulator)
    /// - Changing Font Size in Settings (when run on device)
    @objc
    func contentSizeCategoryDidChange(_ notification: NSNotification) {
        guard (notification.object as? NSObject) !== self else { return }
        guard let newValue = notification.userInfo?[UIContentSizeCategory.newValueUserInfoKey] as? String else { return }

        let newSize = UIContentSizeCategory(rawValue: newValue)
        self.selectedSizeCategory = newSize
    }

    // MARK: - Private

    private func updateChildSizeCatagory() {
        let traits = UITraitCollection(preferredContentSizeCategory: self.selectedSizeCategory)
        self.setOverrideTraitCollection(traits, forChild: self.childViewController)

        // Posting UIContentSizeCategory.didChangeNotification will trigger, among other things, UITableView relayout.
        // This relayout causes UITableView datasource to reload its cells - they will be configured with the new font.
        // I'm not sure if this behaviour a bug or a feature, as it's not documented anywhere (iOS 12.2)
        //
        // Keep in mind that the UIContentSizeCategory posted in userInfo payload will be different to the one
        // returned by UIApplication.preferredContentSizeCategory or UIScreen.traitCollection.preferredContentSizeCategory.
        // This might result in bugs in more complex apps.
        let userInfo = [UIContentSizeCategory.newValueUserInfoKey: self.selectedSizeCategory.rawValue]
        NotificationCenter.default.post(name: UIContentSizeCategory.didChangeNotification, object: self, userInfo: userInfo)
    }

    private func updateChildFont() {
        self.childViewController.font = self.customFontSwitch.isOn ? self.customFont : nil
    }
}
