//
//  StateViewController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 30.09.2020.
//

import UIKit

open class StateViewController: UIViewController {
    public weak var currentViewController: UIViewController?
    
    public func updateController(with newController: UIViewController) {
        guard newController != currentViewController else { return }
        
        removeController()
        addController(newController)
        
        currentViewController = newController
    }
    
    private func addController(_ controller: UIViewController) {
        addChild(controller)
        view.addSubviewPinnedToBounds(controller.view)
        controller.didMove(toParent: self)
    }
    
    private func removeController() {
        guard let controller = currentViewController else { return }
        
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
}
