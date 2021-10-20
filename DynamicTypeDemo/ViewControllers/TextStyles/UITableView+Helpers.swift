//
//  UITableView+Helpers.swift
//  DynamicTypeDemo
//
//  Created by Алексей Берёзка on 20.10.2021.
//

import Foundation
import UIKit

public extension UITableView {
    
    func registerCell<CellType>(ofType: CellType.Type)
    where CellType: UITableViewCell {
        let className = String(describing: CellType.self)
        self.register(CellType.self, forCellReuseIdentifier: className)
    }
    
    /**
     Load nib with cell by name and register it in the tableView by reuseId that also equal to class'es name
     */
    func registerCellFromNib<CellType>(ofType: CellType.Type)
    where CellType: UITableViewCell {
        let classString = String(describing: CellType.self)
        let nib         = UINib(nibName: classString, bundle: Bundle(for: CellType.self))
        
        self.register(nib, forCellReuseIdentifier: classString)
    }
    
    /**
     Deque cell by reuseId that is equal to class'es name
     */
    func dequeueCellOf<CellType>(type: CellType.Type, for indexPath: IndexPath) -> CellType
    where CellType: UITableViewCell {
        let cellId = String(describing: type.self)
        return self.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellType
    }
}
