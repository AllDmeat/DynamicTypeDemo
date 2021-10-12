//
//  UIView+LargeContent.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

extension UIView {
    public func enableLargeContent(title: String? = nil,
                                   image: UIImage? = nil,
                                   scales: Bool = true,
                                   insets: UIEdgeInsets = .zero) {
        largeContentTitle = title
        largeContentImage = image
        scalesLargeContentImage = scales
        largeContentImageInsets = insets
        
        if !showsLargeContentViewer {
            showsLargeContentViewer = true
            addInteraction(UILargeContentViewerInteraction())
        }
    }
}
