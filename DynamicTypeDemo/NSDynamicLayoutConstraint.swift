//
//  NSDynamicLayoutConstraint.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

/// Adjusts spacing based on trait collection
class NSDynamicLayoutConstraint: NSLayoutConstraint {
    private var preferredConstant: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        observeContentSizeChanges()
        preferredConstant = constant
        
        updateDynamicConstant()
    }
    
    override var constant: CGFloat {
        didSet {
            preferredConstant = constant
            updateDynamicConstant()
        }
    }
    
    deinit {
        stopObservingContentSizeChanges()
    }
}

// MARK: - Observe
extension NSDynamicLayoutConstraint {
    private func observeContentSizeChanges() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contentSizeDidChange(notification:)),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }
    
    private func stopObservingContentSizeChanges() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIContentSizeCategory.didChangeNotification,
                                                  object: nil)
    }
    
    @objc
    private func contentSizeDidChange(notification: Notification) {
        updateDynamicConstant()
    }
}

// MARK: - Update
extension NSDynamicLayoutConstraint {
    private func updateDynamicConstant() {
        guard let view = firstItem as? UIView else {
            return
        }
        
        super.constant = preferredConstant.scaled(for: view.traitCollection)
    }
}
