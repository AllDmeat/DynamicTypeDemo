//
//  DynamicStackView.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

/// Adjusts spacing based on trait collection
public class DynamicStackView: UIStackView {
    
    private var preferredSpacing: CGFloat = 0
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        
        updateDynamicSpacing()
    }
    
    // MARK: - Observe content size
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateDynamicSpacing()
    }
}

extension DynamicStackView {
    public override var spacing: CGFloat {
        didSet {
            preferredSpacing = spacing
            updateDynamicSpacing()
        }
    }
    
    private func updateDynamicSpacing() {
        super.spacing = preferredSpacing.scaled(for: traitCollection)
    }
}

