//
//  SwitchingViewController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

class SwitchingViewController: StateViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        update(for: traitCollection.preferredContentSizeCategory)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        update(for: traitCollection.preferredContentSizeCategory)
    }
    
    func update(for contentSize: UIContentSizeCategory) {
        let viewController = childViewController(for: contentSize)
        updateController(with: viewController)
    }
    
    func childViewController(for contentSize: UIContentSizeCategory) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vcIdentifier: String
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
           vcIdentifier = "SwitchingAccessibleViewController"
        } else {
            vcIdentifier = "SwitchingDefaultViewController"
        }
        
        return storyboard.instantiateViewController(withIdentifier: vcIdentifier)
    }
}
