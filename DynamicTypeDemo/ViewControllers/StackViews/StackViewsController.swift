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
            .init(body: "There are two text styles: Body on the left and Caption 1 on the right",
                  caption: "They both scale and become hard to read at large content sizes",
                  axis: .init(all: .horizontal),
                  alignment: .init(all: .top),
                  dynamicSpacing: false),
            
            .init(body: "There are same text styles, but they change their layout based on text size",
                  caption: "and once text sizes is one of 'accessible' — this labels goes one below the other one",
                  axis: .init(defaultAxis: .horizontal,
                              accessible: .vertical),
                  alignment: .init(defaultAlignment: .top,
                                   accessible: .leading),
                  dynamicSpacing: false),
            
            .init(body: "Everything is the same as before",
                  caption: "but here we are using dynamic spacing between labels so that they won't stuck together",
                  axis: .init(defaultAxis: .horizontal,
                              accessible: .vertical),
                  alignment: .init(defaultAlignment: .top,
                                   accessible: .leading),
                  dynamicSpacing: true)
        ])
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCellFromNib(ofType: StackViewCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.sections[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueCellOf(type: StackViewCell.self, for: indexPath)
        cell.viewModel = viewModel
        return cell
    }
}

extension StackViewsController {
    struct ViewModel {
        let sections: [Section]
        
        struct Section {
            
            let items: [Item]
            
            struct Item {
                let body: String
                let caption: String
                
                let axis: AccessibleStackView.PreferredAxis
                let alignment: AccessibleStackView.PreferredAlignment
                let dynamicSpacing: Bool
                
                static let empty = Item(body: "",
                                        caption: "",
                                        axis: .init(all: .vertical),
                                        alignment: .init(all: .leading),
                                        dynamicSpacing: false)
            }
            
            
        }
    }
}
