//
//  ViewController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var mainStackView: AccessibleStackView!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var longTapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStackView.preferredAlignment = .init(defaultAlignment: .center,
                                                 accessible: .leading)
        
        mainStackView.preferredAxis = .init(defaultAxis: .vertical,
                                            accessible: .vertical)
        
        longTapButton.titleLabel?.adjustsFontForContentSizeCategory = true
        longTapButton.enableLargeContent(title: longTapButton.title(for: .normal),
                                         image: longTapButton.image(for: .normal))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let switchingVC = segue.destination as? SwitchingViewController {
            switchingVC.view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstView.layer.cornerRadius = CGFloat(8).scaled(for: traitCollection)
    }
}

