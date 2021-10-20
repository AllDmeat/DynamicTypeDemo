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
    
    var viewModel: TextStylesViewController.ViewModel.Section.Item = .empty {
        didSet {
            update(with: viewModel)
        }
    }
    
    private func update(with viewModel: TextStylesViewController.ViewModel.Section.Item) {
        label.text = viewModel.text
        label.font = viewModel.font
    }
}
