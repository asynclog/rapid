//
//  RapidTableView.swift
//  Freedom
//
//  Created by infiq on 2018/1/31.
//  Copyright © 2018年 asynclog. All rights reserved.
//

import UIKit
import ObjectiveC

public typealias RapidTableView = UITableView

public extension UITableView {
    var rapid: UITableView {
        get {
            let isNotRapid = (objc_getAssociatedObject(self, &AssocitionKey.adapter) != nil) ? false : true
            if isNotRapid {
                let adapter = RapidAdapter()
                self.dataSource = adapter
                self.delegate   = adapter
                objc_setAssociatedObject(self, &AssocitionKey.adapter, adapter, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return self
        }
    }
}

public extension RapidTableView {
    
    private enum AssocitionKey {
        static var adapter = "adapter"
    }
    
    static func view(frame: CGRect, style: UITableViewStyle) -> RapidTableView {
        let tableView = UITableView(frame: frame, style: style).rapid
        return tableView
    }
    
    
    func addSections(_ sections: [Section])  {
        let dataSource = objc_getAssociatedObject(self,  &AssocitionKey.adapter) as! RapidAdapter
        dataSource.sections.append(contentsOf: sections)
    }
    
    func sections() -> [Section] {
        let dataSource = objc_getAssociatedObject(self,  &AssocitionKey.adapter) as! RapidAdapter
        return dataSource.sections
    }
    
    func removeAllSections()  {
        let dataSource = objc_getAssociatedObject(self,  &AssocitionKey.adapter) as! RapidAdapter
        dataSource.sections.removeAll()
    }
    
    func extAdapter(to ext:NSObject) {
        let adapter = objc_getAssociatedObject(self,  &AssocitionKey.adapter) as! RapidAdapter
        adapter.compensator = ext
    }
    
//    func registCell<T: UITableViewCell>(cellClass: T.Type)  {
//        self.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
//    }
//
//    func registNib<T: UITableViewCell>(cellClass: T.Type)  {
//        print("\(T.classForCoder())")
//        let nib = UINib(nibName:  "\(T.classForCoder())", bundle: Bundle(for: cellClass))
//        self.register(nib, forCellReuseIdentifier: NSStringFromClass(cellClass))
//    }
}

class RapidAdapter:NSObject {
    
    var sections = [Section]()
    
    var compensator: NSObject?
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        guard let c = compensator else {
            return nil
        }
        if (c.responds(to: aSelector)) {
            return compensator
        }
        return nil
    }
    
}

extension RapidAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
//        row.indexPath  = indexPath
        var cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier)
        if cell == nil {
            cell = (row as! Creatable).createCell()
        }
        row.update(cell: cell!)
        return cell!;
    }
}

extension RapidAdapter: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].titleClosure?()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerViewClosure?()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return sections[section].headerViewHeightClosure()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return sections[section].footerViewClosure?()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerViewHiehgtClosure()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = sections[indexPath.section].rows[indexPath.row]
        row.selectAction?(row)
    }
    
}

