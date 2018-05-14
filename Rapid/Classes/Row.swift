//
//  File.swift
//  Freedom
//
//  Created by infiq on 2018/1/31.
//  Copyright © 2018年 asynclog. All rights reserved.
//

import UIKit

//protocol ViewModelType: class {
//
//}

@objc public protocol Cellable {
    static func isXib() -> Bool
    @objc optional static func xibName() -> String?
}

extension Cellable {
    static func xibName() -> String? {
        return nil
    }
}


public protocol ViewModelabel {
    associatedtype ViewModel
}

public protocol Updatable: ViewModelabel {
    func update(_ viewModel: ViewModel?)
}



public class Row<Cell>: RowType, Creatable, PrivateModuleUsable where Cell: Updatable, Cell: UITableViewCell, Cell: Cellable {

    
    // MARK: -PrivateModuleUsable
    public var height: CGFloat
    var viewModel: Cell.ViewModel?
    public let reuseIdentifier = "\(NSStringFromClass(Cell.self))"
    public let cellClass: AnyClass = Cell.self
    public var selectAction: CellSelectAction?
    
    public var xib: Bool
    
    public init(height: CGFloat = CGFloat.leastNormalMagnitude,viewModel: Cell.ViewModel? = nil, xib: Bool = false) {
        self.height = height
        self.viewModel = viewModel
        self.xib = xib
    }
    
    public func update(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.update(viewModel)
        }
    }
    
    public func cellItem<M>() -> M {
        return viewModel as! M
    }
    
    func createCell<C>() -> C where C: UITableViewCell {
        if Cell.isXib() {
            var xibName = Cell.xibName()
            if xibName == nil {
                xibName = "\(Cell.classForCoder())"
            }
            return Bundle(for: cellClass).loadNibNamed(xibName!, owner: nil, options: nil)?.first as! C
        }
        return Cell(style: .default, reuseIdentifier: reuseIdentifier) as! C

    }

}

public typealias CellSelectAction = (_ row: RowType) -> (Void)

protocol Creatable {
    func createCell<C: UITableViewCell>() -> C
}

protocol PrivateModuleUsable {
//    func setIndexPath(_ indexPath: NSIndexPath?)
}

public protocol RowType {
//    var tag: RowTag { get }
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    var height: CGFloat {get}
    var selectAction: CellSelectAction? {get set}
    var xib: Bool { get }
    
    func update(cell: UITableViewCell)
    
    func cellItem<M>() -> M
    
}


//public class RowTags {
//    fileprivate init() {}
//}
//
//public class RowTag: RowTags {
//    public let _key: String
//
//    public init(_ key: String) {
//        self._key = key
//        super.init()
//    }
//}
//
//extension RowTag: Hashable {
//    public static func ==(lhs: RowTag, rhs: RowTag) -> Bool {
//        return lhs.hashValue == rhs.hashValue
//    }
//
//    public var hashValue: Int {
//        return _key.hashValue
//    }
//}
//
//extension RowTags {
//    static let none = RowTag("")
//}

