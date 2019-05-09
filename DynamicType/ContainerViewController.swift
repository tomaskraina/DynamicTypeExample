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
        // - override 'UIViewController.traitCollectionDidChange(_:)' method
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
    /// This method is called when the prefered content size category changes by:
    /// - Changing Font Size in Accessibility Inspector (when run on simulator)
    /// - Changing Font Size in Settings (when run on device)
    @objc
    func contentSizeCategoryDidChange(_ notification: NSNotification) {
        guard let newValue = notification.userInfo?[UIContentSizeCategory.newValueUserInfoKey] as? String else { return }

        let newSize = UIContentSizeCategory(rawValue: newValue)
        self.selectedSizeCategory = newSize
    }

    // MARK: - Private

    private func updateChildSizeCatagory() {
        let traits = UITraitCollection(preferredContentSizeCategory: self.selectedSizeCategory)
        self.setOverrideTraitCollection(traits, forChild: self.childViewController)
    }

    private func updateChildFont() {
        self.childViewController.font = self.customFontSwitch.isOn ? self.customFont : nil
    }
}
