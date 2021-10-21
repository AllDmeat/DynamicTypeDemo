//
//  TextStyleCell.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 20.10.2021.
//

import Foundation
import UIKit

class TextStyleCell: UITableViewCell {
    @IBOutlet
    private weak var title: UILabel!
    
    @IBOutlet
    private weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        title.adjustsFontForContentSizeCategory = true
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .caption1)
        subtitle.adjustsFontForContentSizeCategory = true
    }
    
    var viewModel: TextStylesViewController.ViewModel.Section.Item = .empty {
        didSet {
            update(with: viewModel)
        }
    }
    
    private func update(with viewModel: TextStylesViewController.ViewModel.Section.Item) {
        title.text = viewModel.text
        title.font = viewModel.font
        
        subtitle.text = subtitleText(from: viewModel)
        subtitle.isHidden = subtitle.text == nil
        
        minimumContentSizeCategory = viewModel.minimumContentSizeCategory
        maximumContentSizeCategory = viewModel.maximumContentSizeCategory
    }
    
    private func subtitleText(from viewModel: TextStylesViewController.ViewModel.Section.Item) -> String? {
        let minSize = viewModel.minimumContentSizeCategory.map { "Min size: \($0.humanReadableDescription)" }
        let maxSize = viewModel.maximumContentSizeCategory.map { "Max size: \($0.humanReadableDescription)" }
        return [minSize, maxSize]
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}

extension UIContentSizeCategory {
    var humanReadableDescription: String {
        switch self {
        case .extraSmall:
            return "extra small"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .extraLarge:
            return "extra large"
        case .extraExtraLarge:
            return "extra extra large"
        case .extraExtraExtraLarge:
            return "extra extra extra large"
        case .accessibilityMedium:
            return "accessibility medium"
        case .accessibilityLarge:
            return "accessibility large"
        case .accessibilityExtraLarge:
            return "accessibility extra large"
        case.accessibilityExtraExtraLarge:
            return "accessibility extra extra large"
        case.accessibilityExtraExtraExtraLarge:
            return "accessibility extra extra extra large"
        default:
            return String(describing: self)
        }
    }
}
