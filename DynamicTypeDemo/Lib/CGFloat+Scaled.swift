//
//  CGFloat+Scaled.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

extension CGFloat {
    public func scaled(as textStyle: UIFont.TextStyle = .body,
                       for traitCollection: UITraitCollection) -> Self {
        UIFontMetrics(forTextStyle: textStyle).scaledValue(for: self, compatibleWith: traitCollection)
    }
}

fileprivate extension UIContentSizeCategory {
    static var `default`: UIContentSizeCategory = .large
}
