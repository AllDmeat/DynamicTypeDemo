//
//  StackViewDefaultBehaviourCell.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 21.10.2021.
//

import Foundation
import UIKit

class StackViewRotateAndScaleSpacingBehaviourCell: UITableViewCell {
    
    @IBOutlet weak var stackView: AccessibleStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.preferredAxis = .init(defaultAxis: .horizontal,
                                        accessible: .vertical)
        
        stackView.preferredAlignment = .init(defaultAlignment: .top,
                                             accessible: .leading)
        
        stackView.dynamicSpacing = true
    }
}
