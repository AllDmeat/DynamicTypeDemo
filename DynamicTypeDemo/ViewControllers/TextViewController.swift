//
//  TextViewController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 12.10.2021.
//

import UIKit
import ScrollingContentViewController

class TextViewController: ScrollingContentViewController {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet private var mainStackView: AccessibleStackView!
    
    @IBOutlet private var descriptionStackView: AccessibleStackView!
    @IBOutlet private var stylesStackView: AccessibleStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.preferredAxis = .init(all: .vertical)
        descriptionStackView.preferredAxis = .init(all: .vertical)
        stylesStackView.preferredAxis = .init(all: .vertical)
        
        stylesStackView.preferredAlignment = .init(defaultAlignment: .center,
                                             accessible: .leading)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthConstraint.constant = view.frame.width
    }
}
