//
//  extensions.swift
//  DynamicType
//
//  Created by Tom Kraina on 09/05/2019.
//  Copyright © 2019 Tom Kraina. All rights reserved.
//

import UIKit

// MARK: - UIFont.TextStyle: CustomStringConvertible

extension UIFont.TextStyle: CustomStringConvertible {

    public var description: String {
        return self.rawValue.replacingOccurrences(of: "UICTFontTextStyle", with: "")
    }
}

// MARK: - UIContentSizeCategory: CustomStringConvertible

extension UIContentSizeCategory: CustomStringConvertible {

    public var description: String {
        return self.rawValue.replacingOccurrences(of: "UICTContentSizeCategory", with: "")
    }
}
