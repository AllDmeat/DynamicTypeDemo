//
//  AccessibleStackView.swift
//  DUIKit
//
//  Created by Алексей Берёзка on 28.04.2020.
//

import UIKit

/// Adjusts axis based on trait collection
public final class AccessibleStackView: UIStackView {

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
        updateDynamicSpacing(to: traitCollection.preferredContentSizeCategory)
    }

    // MARK: - Alignment

    public var preferredAlignment: PreferredAlignment? {
        didSet {
            updateToCurrentContentSize()
        }
    }
    public var preferredAlignmentForSizeClasses: [SizeClassPair: PreferredAlignment] = [:] {
        didSet {
            updateToCurrentContentSize()
        }
    }

    private func updateAlignment(to contentSize: UIContentSizeCategory) {
        guard let preferredAlignmentToApply = preferredAlignmentToApply() else { return }

        if contentSize.isAccessibilityCategory {
            alignment = preferredAlignmentToApply.accessible
        } else {
            alignment = preferredAlignmentToApply.default
        }
    }

    private func preferredAlignmentToApply() -> PreferredAlignment? {
        preferredAlignmentForSizeClasses[.init(from: traitCollection)] ?? preferredAlignment
    }

    // MARK: - Spacing

    private var preferredSpacing: CGFloat = 0 {
        didSet {
            updateToCurrentContentSize()
        }
    }
    public var dynamicSpacing: Bool = true {
        didSet {
            updateToCurrentContentSize()
        }
    }

    public override var spacing: CGFloat {
        didSet {
            preferredSpacing = spacing
        }
    }

    private func updateDynamicSpacing(to contentSize: UIContentSizeCategory) {
        guard dynamicSpacing else {
            return
        }

        super.spacing = preferredSpacing.scaled(for: traitCollection)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        // reset when load from storyboard
        updateDynamicSpacing(to: traitCollection.preferredContentSizeCategory)
    }

    // MARK: - Axis

    public var preferredAxis: PreferredAxis = .init(
        defaultAxis: .horizontal,
        accessible: .vertical
    ) {
        didSet {
            updateToCurrentContentSize()
        }
    }

    public var preferredAxisForSizeClasses: [SizeClassPair: PreferredAxis] = [:] {
        didSet {
            updateToCurrentContentSize()
        }
    }
    
    private func updateAxis(to contentSize: UIContentSizeCategory) {
        let preferredAxisToApply = preferredAxisToApply()

        if contentSize.isAccessibilityCategory {
            axis = preferredAxisToApply.accessible
        } else {
            axis = preferredAxisToApply.default
        }
    }

    private func preferredAxisToApply() -> PreferredAxis {
        preferredAxisForSizeClasses[.init(from: traitCollection)] ?? preferredAxis
    }
}

extension AccessibleStackView {
    public struct PreferredAxis {
        let `default`: NSLayoutConstraint.Axis
        let accessible: NSLayoutConstraint.Axis

        public init(
            defaultAxis: NSLayoutConstraint.Axis,
            accessible: NSLayoutConstraint.Axis
        ) {
            self.default = defaultAxis
            self.accessible = accessible
        }
    }

    public struct PreferredAlignment {
        let `default`: UIStackView.Alignment
        let accessible: UIStackView.Alignment

        public init(
            defaultAlignment: UIStackView.Alignment,
            accessible: UIStackView.Alignment
        ) {
            self.default = defaultAlignment
            self.accessible = accessible
        }
    }
}

extension AccessibleStackView.PreferredAxis {
    public init(all value: NSLayoutConstraint.Axis) {
        self.init(defaultAxis: value, accessible: value)
    }

    static let horizontal = Self(all: .horizontal)
    static let vertical = Self(all: .vertical)
}

extension AccessibleStackView.PreferredAlignment {
    public init(all value: UIStackView.Alignment) {
        self.init(defaultAlignment: value, accessible: value)
    }

    static let fill = Self(all: .fill)
    static let leading = Self(all: .leading)
    static let top = Self(all: .top)
    static let firstBaseline = Self(all: .firstBaseline)
    static let center = Self(all: .center)
    static let trailing = Self(all: .trailing)
    static let bottom = Self(all: .bottom)
    static let lastBaseline = Self(all: .lastBaseline)
}

extension AccessibleStackView {
    public struct SizeClassPair: Hashable {
        let h: UIUserInterfaceSizeClass
        let v: UIUserInterfaceSizeClass

        public init(
            h: UIUserInterfaceSizeClass,
            v: UIUserInterfaceSizeClass
        ) {
            self.h = h
            self.v = v
        }
    }
}

extension AccessibleStackView.SizeClassPair {
    public static let allUnspecifiedH = allH(ofSize: .unspecified)
    public static let allCompactH = allH(ofSize: .compact)
    public static let allRegularH = allH(ofSize: .regular)

    public static let allUnspecifiedV = allV(ofSize: .unspecified)
    public static let allCompactV = allV(ofSize: .compact)
    public static let allRegularV = allV(ofSize: .regular)

    private static func allH(ofSize size: UIUserInterfaceSizeClass) -> [Self] {
        UIUserInterfaceSizeClass.allCases.map { .init(h: size, v: $0) }
    }

    private static func allV(ofSize size: UIUserInterfaceSizeClass) -> [Self] {
        UIUserInterfaceSizeClass.allCases.map { .init(h: $0, v: size) }
    }
}

extension UIUserInterfaceSizeClass: CaseIterable {
    public static var allCases: [UIUserInterfaceSizeClass] {
        [
            .unspecified,
            .compact,
            .regular,
        ]
    }
}

extension AccessibleStackView.SizeClassPair {
    public init(from traitCollection: UITraitCollection) {
        self.init(
            h: traitCollection.horizontalSizeClass,
            v: traitCollection.verticalSizeClass
        )
    }
}
