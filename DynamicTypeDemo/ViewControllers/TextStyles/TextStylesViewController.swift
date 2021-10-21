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
                internal init(text: String,
                              font: UIFont,
                              minimumContentSizeCategory: UIContentSizeCategory? = nil,
                              maximumContentSizeCategory: UIContentSizeCategory? = nil
                ) {
                    self.text = text
                    self.font = font
                    self.minimumContentSizeCategory = minimumContentSizeCategory
                    self.maximumContentSizeCategory = maximumContentSizeCategory
                }
                
                let text: String
                let font: UIFont
                
                let minimumContentSizeCategory: UIContentSizeCategory?
                let maximumContentSizeCategory: UIContentSizeCategory?
                
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
                textStylesBasedFontsSection(),
                systemFontsSection(minSize: .accessibilityMedium, maxSize: nil),
                systemFontsSection(minSize: nil, maxSize: .accessibilityMedium),
                preinstalledFontsSection()
            ])
        }
        
        private func textStylesBasedFontsSection() -> ViewModel.Section {
            .init(headerTitle: "Default text styles",
                  items: UIFont.TextStyle.allCases.map(ViewModel.Section.Item.init),
                  footerTitle:
"""
UIFont.preferredFont(forTextStyle:)
"""
            )
        }
        
        private func systemFontsSection(minSize: UIContentSizeCategory?,
                                        maxSize: UIContentSizeCategory?) -> ViewModel.Section {
            .init(headerTitle: "System fonts",
                  items: [
                    .italicSystemFont(minSize: minSize, maxSize: maxSize),
                    .monospacedSystemFont(minSize: minSize, maxSize: maxSize)
                  ],
                  footerTitle: """
UIFontMetrics(forTextStyle:).scaledValue(for:compatibleWith:)
"""
            )
        }
        
        private func preinstalledFontsSection() -> ViewModel.Section {
            let scalingFonts = UIFont.availableFonts.random(10).map { font in
                font.scaling()
            }
            return .init(headerTitle: "Custom fonts (preinstalled on iOS)",
                         items: scalingFonts.map(ViewModel.Section.Item.init),
                         footerTitle: """
UIFontMetrics(forTextStyle:).scaledValue(for:compatibleWith:)
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
    static func italicSystemFont(minSize: UIContentSizeCategory?,
                                 maxSize: UIContentSizeCategory?) -> Self {
        .init(
            text: "Italic system font",
            font: .italicSystemFont(ofSize: UIFont.labelFontSize).scaling(),
            minimumContentSizeCategory: minSize,
            maximumContentSizeCategory: maxSize
        )
    }
    
    static func monospacedSystemFont(minSize: UIContentSizeCategory?,
                                     maxSize: UIContentSizeCategory?) -> Self {
        .init(
            text: "Monospaced system font",
            font: .monospacedSystemFont(ofSize: UIFont.labelFontSize,
                                        weight: .regular).scaling(),
            minimumContentSizeCategory: minSize,
            maximumContentSizeCategory: maxSize
        )
    }
}

extension UIFont {
    func scaling(as style: UIFont.TextStyle = .body) -> UIFont {
        UIFontMetrics(forTextStyle: style).scaledFont(for: self)
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
