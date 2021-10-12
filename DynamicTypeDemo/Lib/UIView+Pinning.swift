//
//  UIView+Pinning.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

public extension UIView {
    func addSubviewPinnedToBounds(_ view: UIView) {
        self.addSubview(view)
        self.pinToBounds(view)
    }
    
    func pinToBounds(_ view: UIView,
                     with insets: NSDirectionalEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor,
                                      constant: insets.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor,
                                         constant: insets.bottom),
            view.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: insets.leading),
            view.trailingAnchor.constraint(equalTo: trailingAnchor,
                                           constant: insets.trailing),
        ])
    }
}
