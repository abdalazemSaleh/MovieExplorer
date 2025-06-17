//
//  TableView+.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 01/12/2024.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(with: T.Type) {
        let identifier = String(describing: T.self)
        register(.init(nibName: identifier, bundle: .main), forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        let identifier = String(describing: T.self)
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Error in cell")
        }
        return header
    }
}
