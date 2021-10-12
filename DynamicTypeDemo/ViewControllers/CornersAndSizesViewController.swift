//
//  CornersAndSizesViewController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 12.10.2021.
//

import UIKit
import ScrollingContentViewController

class CornersAndSizesViewController: ScrollingContentViewController {
    
    @IBOutlet private var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet private var mainStackView: AccessibleStackView!
    
    @IBOutlet private var separatorStackView: AccessibleStackView!
    
    @IBOutlet private var squareCornerRadiusStackView: AccessibleStackView!
    
    @IBOutlet private var squareSizeStackView: AccessibleStackView!
    
    
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var square: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.preferredAxis = .init(all: .vertical)
        separatorStackView.preferredAxis = .init(all: .vertical)
        squareCornerRadiusStackView.preferredAxis = .init(all: .vertical)
        squareSizeStackView.preferredAxis = .init(all: .vertical)
        
        square.layer.cornerCurve = .continuous
        
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthConstraint.constant = view.frame.width
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateUI()
    }
    
    private func updateUI() {
        // update separator height
        separatorHeightConstraint.constant = (1 / UIScreen.main.scale).scaled(for: traitCollection)
        
        // Update corner radius
        square.layer.cornerRadius = CGFloat(16).scaled(for: traitCollection)
    }
}
