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
        label.font = UIFont.preferredFont(forTextStyle: viewModel.style)
    }
}

extension TextStyleCell {
    struct ViewModel {
        let text: String
        let style: UIFont.TextStyle
        
        static let empty = ViewModel(text: "", style: .body)
    }
}
