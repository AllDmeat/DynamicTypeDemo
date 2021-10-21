//
//  StackViewsController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 12.10.2021.
//

import UIKit

class StackViewsController: UITableViewController {
    private lazy var viewModel = ViewModel(sections: [
        .init(items: [
            .defaultBehaviour,
            .rotateAxis,
            .rotateAxisAndScaleSpacing
        ])
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCellFromNib(ofType: StackViewDefaultBehaviourCell.self)
        tableView.registerCellFromNib(ofType: StackViewRotateBehaviourCell.self)
        tableView.registerCellFromNib(ofType: StackViewRotateAndScaleSpacingBehaviourCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .defaultBehaviour:
            return tableView.dequeueCellOf(type: StackViewDefaultBehaviourCell.self,
                                           for: indexPath)
        case .rotateAxis:
            return tableView.dequeueCellOf(type: StackViewRotateBehaviourCell.self,
                                           for: indexPath)
        case .rotateAxisAndScaleSpacing:
            return tableView.dequeueCellOf(type: StackViewRotateAndScaleSpacingBehaviourCell.self,
                                           for: indexPath)
        }
    }
}

extension StackViewsController {
    struct ViewModel {
        let sections: [Section]
        
        struct Section {
            
            let items: [Item]
            
            enum Item {
                case defaultBehaviour
                case rotateAxis
                case rotateAxisAndScaleSpacing
            }
        }
    }
}
