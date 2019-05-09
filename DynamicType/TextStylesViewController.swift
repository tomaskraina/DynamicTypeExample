//
//  TextStylesViewController.swift
//  DynamicType
//
//  Created by Tom Kraina on 09/05/2019.
//  Copyright © 2019 Tom Kraina. All rights reserved.
//

import UIKit

class TextStylesViewController: UITableViewController {

    // MARK: - Configuration

    var font: UIFont? {
        didSet {
            self.reloadView()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet weak var stackView: UIStackView!

    // MARK: - Properties

    private lazy var styles: [UIFont.TextStyle] = [
        .body,
        .callout,
        .caption1,
        .caption2,
        .footnote,
        .headline,
        .subheadline,
        .largeTitle, // Fonts created with .largeTitle are not scaled automatically: http://www.openradar.me/45338369
        .title1,
        .title2,
        .title3,
    ]

    private var currentSizeCategory: UIContentSizeCategory {
        return self.traitCollection.preferredContentSizeCategory
    }

    // MARK: - UIViewController lifecycle

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.reloadView()
    }

    // MARK: - Privates

    private func reloadView() {
        guard self.isViewLoaded else { return }

        self.tableView.reloadData()
    }

    // MARK: - UITableViewControllerDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.styles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let style = self.styles[indexPath.row]
        configureLabel(cell.textLabel!, textStyle: style, defaultFont: self.font, traits: self.traitCollection)

        return cell
    }
}

// MARK: - Helpers

func makeLabel(textStyle: UIFont.TextStyle, defaultFont: UIFont?, traits: UITraitCollection) -> UILabel {
    let label = UILabel()
    configureLabel(label, textStyle: textStyle, defaultFont: defaultFont, traits: traits)
    return label
}

func configureLabel(_ label: UILabel, textStyle: UIFont.TextStyle, defaultFont: UIFont?, traits: UITraitCollection) {
    if let font = defaultFont {
        // This 'metrics' property on UIFont.TextStyle is available only in Swift (not in ObjC)
        // and is also missing from docs: https://twitter.com/krajaac/status/1126074002655666177
        label.font = textStyle.metrics.scaledFont(for: font, compatibleWith: traits)
    } else {
        label.font = UIFont.preferredFont(forTextStyle: textStyle, compatibleWith: traits)
    }
    label.text = "\(textStyle.description) \(label.font.pointSize)pt"
}
