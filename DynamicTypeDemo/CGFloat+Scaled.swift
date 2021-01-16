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
        if #available(iOS 11.0, *) {
            return nativeScaled(as: textStyle, for: traitCollection)
        } else {
            return customScaled(as: textStyle, for: traitCollection)
        }
    }
}

extension CGFloat {
    private func nativeScaled(as textStyle: UIFont.TextStyle = .body,
                              for traitCollection: UITraitCollection) -> Self {
        UIFontMetrics(forTextStyle: textStyle).scaledValue(for: self, compatibleWith: traitCollection)
    }
}

extension CGFloat {
    private func customScaled(as textStyle: UIFont.TextStyle = .body,
                              for traitCollection: UITraitCollection) -> Self {
        let font = UIFont.preferredFont(forTextStyle: textStyle,
                                        compatibleWith: traitCollection)
        
        let ratio = self / UIFont.nonScaled(for: textStyle).pointSize
        
        let newValue = font.pointSize * ratio
        
        return newValue
    }
}

fileprivate extension UIFont {
    static func nonScaled(for textStyle: UIFont.TextStyle) -> UIFont {
        let traitCollection = UITraitCollection(preferredContentSizeCategory: .default)
        return UIFont.preferredFont(forTextStyle: textStyle,
                                    compatibleWith: traitCollection)
    }
}

fileprivate extension UIContentSizeCategory {
    static var `default`: UIContentSizeCategory = .large
}
