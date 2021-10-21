//
//  StackViewCell.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 21.10.2021.
//

import Foundation
import UIKit

class StackViewCell: UITableViewCell {
    
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    @IBOutlet weak var stackView: AccessibleStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var viewModel: StackViewsController.ViewModel.Section.Item = .empty {
        didSet {
            update(with: viewModel)
        }
    }
    
    private func update(with viewModel: StackViewsController.ViewModel.Section.Item) {
        body.text = viewModel.body
        caption.text = viewModel.caption
        
        stackView.preferredAxis = viewModel.axis
        stackView.preferredAlignment = viewModel.alignment
        stackView.dynamicSpacing = viewModel.dynamicSpacing
    }
}
