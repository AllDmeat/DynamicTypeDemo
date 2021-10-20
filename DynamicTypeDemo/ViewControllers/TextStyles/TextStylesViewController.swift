//
//  TextStylesViewController.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 12.10.2021.
//

import UIKit
import ScrollingContentViewController

class TextStylesViewController: UITableViewController {
    private let factory = ViewModelFactory()
    lazy var viewModel = factory.createViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCellFromNib(ofType: TextStyleCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellOf(type: TextStyleCell.self, for: indexPath)
        cell.viewModel = viewModel.items[indexPath.row]
        return cell
    }
}

extension TextStylesViewController {
    struct ViewModel {
        let items: [TextStyleCell.ViewModel]
    }
}

extension TextStylesViewController {
    class ViewModelFactory {
        func createViewModel() -> ViewModel {
            let items = UIFont.TextStyle.allCases.map(TextStyleCell.ViewModel.init)
            return .init(items: items)
        }
    }
}

extension TextStyleCell.ViewModel {
    init(_ style: UIFont.TextStyle) {
        self.init(text: style.title,
                  font: UIFont.preferredFont(forTextStyle: style))
    }
}

extension UIFont.TextStyle: CaseIterable {
    public static var allCases: [UIFont.TextStyle] {
        [
            .largeTitle,
            .title1,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .footnote,
            .caption1,
            .caption2
        ]
    }
    
    var title: String {
        switch self {
        case .largeTitle:
            return "Large title"
        case .title1:
            return "Title 1"
        case .title2:
            return "Title 2"
        case .title3:
            return "Title 3"
        case .headline:
            return "Headline"
        case .subheadline:
            return "Subheadline"
        case .body:
            return "Body"
        case .callout:
            return "Callout"
        case .footnote:
            return "Footnote"
        case .caption1:
            return "Caption 1"
        case .caption2:
            return "Caption 2"
        default:
            return "Unknown"
        }
    }
}
