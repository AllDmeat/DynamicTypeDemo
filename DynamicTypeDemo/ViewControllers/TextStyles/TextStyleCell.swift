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
    private var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.adjustsFontForContentSizeCategory = true
    }
    
    var viewModel: ViewModel = .empty {
        didSet {
            update(with: viewModel)
        }
    }
    
    private func update(with viewModel: ViewModel) {
        label.text = viewModel.text
        label.font = viewModel.font
    }
}

extension TextStyleCell {
    struct ViewModel {
        let text: String
        let font: UIFont
        
        static let empty = ViewModel(text: "",
                                     font: UIFont.preferredFont(forTextStyle: .body))
    }
}
