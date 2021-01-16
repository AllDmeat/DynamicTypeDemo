//
//  AccessibleStackView.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

/// Adjusts axis based on trait collection
public class AccessibleStackView: DynamicStackView {
    
    public var preferredAxis = PreferredAxis(defaultAxis: .horizontal,
                                             accessible: .vertical) {
        didSet {
            updateAxis(to: traitCollection.preferredContentSizeCategory)
        }
    }
    
    public var preferredAlignment: PreferredAlignment? {
        didSet {
            updateAlignment(to: traitCollection.preferredContentSizeCategory)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        updateToCurrentContentSize()
    }
    
    // MARK: - Observe content size
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateToCurrentContentSize()
    }
    
    private func updateToCurrentContentSize() {
        updateAxis(to: traitCollection.preferredContentSizeCategory)
        updateAlignment(to: traitCollection.preferredContentSizeCategory)
    }
}

extension AccessibleStackView {
    private func updateAxis(to contentSize: UIContentSizeCategory) {
        if contentSize.isAccessibilityCategory {
            axis = preferredAxis.accessible
        } else {
            axis = preferredAxis.default
        }
    }
    
    private func updateAlignment(to contentSize: UIContentSizeCategory) {
        guard let preferredAlignment = preferredAlignment else { return }
        
        if contentSize.isAccessibilityCategory {
            alignment = preferredAlignment.accessible
        } else {
            alignment = preferredAlignment.default
        }
    }
}

extension AccessibleStackView {
    public struct PreferredAlignment {
        let `default`: UIStackView.Alignment
        let accessible: UIStackView.Alignment
        
        public init(defaultAlignment: UIStackView.Alignment,
                    accessible: UIStackView.Alignment) {
            self.default = defaultAlignment
            self.accessible = accessible
        }
    }
}

extension AccessibleStackView {
    public struct PreferredAxis {
        let `default`: NSLayoutConstraint.Axis
        let accessible: NSLayoutConstraint.Axis
        
        public init(defaultAxis: NSLayoutConstraint.Axis,
                    accessible: NSLayoutConstraint.Axis) {
            self.default = defaultAxis
            self.accessible = accessible
        }
    }
}

