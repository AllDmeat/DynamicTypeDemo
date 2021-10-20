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
        viewModel.sections[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        viewModel.sections[section].footerTitle
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
            let headerTitle: String
            let items: [Item]
            let footerTitle: String
            
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
            .init(headerTitle: "Default text styles",
                  items: UIFont.TextStyle.allCases.map(ViewModel.Section.Item.init),
                  footerTitle:
"""
UIFont.preferredFont(forTextStyle:)
Fonts are scaled by default. Adjusting to current content size automaticaly.
"""
            )
        }
        
        private func customScaling(for traitCollection: UITraitCollection) -> ViewModel.Section {
            .init(headerTitle: "System fonts",
                  items: [
                    .italicSystemFont(for: traitCollection),
                    .monospacedSystemFont(for: traitCollection),
                    .monospacedDigitsSystemFont(for: traitCollection)
                  ],
                  footerTitle: """
UIFontMetrics(forTextStyle:).scaledValue(for:compatibleWith:)
Scaling not font, but it's size. Fonts don't adjust automatically, unless size is recalculated and font is set again.
"""
            )
        }
        
        private func defaultScaling(for traitCollection: UITraitCollection) -> ViewModel.Section {
            let scaledFonts = UIFont.availableFonts.random(10).map { font in
                UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
            }
            return .init(headerTitle: "Custom fonts (preinstalled on iOS)",
                         items: scaledFonts.map(ViewModel.Section.Item.init),
                         footerTitle: """
UIFontMetrics(forTextStyle:).scaledValue(for:compatibleWith:)
Fonts are scaled by default. Adjusting to current content size automaticaly.
"""
            )
        }
    }
}

extension UIFont {
    static var availableFontNames: [String] {
        UIFont.familyNames.flatMap { UIFont.fontNames(forFamilyName: $0) }.unique()
    }
    
    static var availableFonts: [UIFont] {
        UIFont.availableFontNames.compactMap { name in
            UIFont(name: name,
                   size: UIFont.labelFontSize)
        }.unique()
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

extension Collection {
    func random(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
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
    
    static func monospacedDigitsSystemFont(for traitCollection: UITraitCollection) -> Self {
        .init(
            text: """
Monospaced digits system font, 100
""",
            font: .monospacedDigitSystemFont(ofSize: UIFont.labelFontSize.scaled(for: traitCollection), weight: .regular)
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
