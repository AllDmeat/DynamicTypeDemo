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
    lazy var viewModel = factory.createViewModel(for: traitCollection)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCellFromNib(ofType: TextStyleCell.self)
        
        for family in UIFont.familyNames {
            
            let sName: String = family as String
            print("family: \(sName)")
            
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellOf(type: TextStyleCell.self, for: indexPath)
        cell.viewModel = viewModel.sections[indexPath.section].items[indexPath.row]
        return cell
    }
}

extension TextStylesViewController {
    struct ViewModel {
        let sections: [Section]
        
        struct Section {
            let title: String
            let items: [Item]
            
            struct Item {
                let text: String
                let font: UIFont
                
                static let empty = Item(text: "",
                                             font: UIFont.preferredFont(forTextStyle: .body))
            }
        }
    }
}

extension TextStylesViewController {
    class ViewModelFactory {
        func createViewModel(for traitCollection: UITraitCollection) -> ViewModel {
            .init(sections: [
                defaultFontStylesSection(),
                customScaling(for: traitCollection),
                defaultScaling(for: traitCollection)
            ])
        }
        
        private func defaultFontStylesSection() -> ViewModel.Section {
            .init(title: "Default text styles",
                  items: UIFont.TextStyle.allCases.map(ViewModel.Section.Item.init))
        }
        
        private func customScaling(for traitCollection: UITraitCollection) -> ViewModel.Section {
            .init(title: "Custom scaling",
                  items: [
                    .italicSystemFont(for: traitCollection),
                    .monospacedSystemFont(for: traitCollection)
                  ])
        }
        
        private func defaultScaling(for traitCollection: UITraitCollection) -> ViewModel.Section {
            let scaledFonts = UIFont.availableFonts.map { font in
                UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
            }
            return .init(title: "Preinstalled fonts",
                         items: scaledFonts.map(ViewModel.Section.Item.init))
        }
    }
}

extension UIFont {
    static var availableFontNames: [String] {
        UIFont.familyNames.flatMap { UIFont.fontNames(forFamilyName: $0) }
    }
    
    static var availableFonts: [UIFont] {
        UIFont.availableFontNames.compactMap { name in
            UIFont(name: name,
                   size: UIFont.labelFontSize)
        }
    }
}

extension TextStylesViewController.ViewModel.Section.Item {
    static func italicSystemFont(for traitCollection: UITraitCollection) -> Self {
        .init(
            text: "Italic system font",
            font: .italicSystemFont(ofSize: UIFont.labelFontSize.scaled(for: traitCollection))
        )
    }
    
    static func monospacedSystemFont(for traitCollection: UITraitCollection) -> Self {
        .init(
            text: "Monospaced system font",
            font: .monospacedSystemFont(ofSize: UIFont.labelFontSize.scaled(for: traitCollection), weight: .regular)
        )
    }
}

extension TextStylesViewController.ViewModel.Section.Item {
    init(_ style: UIFont.TextStyle) {
        self.init(text: style.title,
                  font: UIFont.preferredFont(forTextStyle: style))
    }
    
    init(_ font: UIFont) {
        self.init(
            text: font.fontName,
            font: font
        )
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
