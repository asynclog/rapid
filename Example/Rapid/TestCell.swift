//
//  TestCell.swift
//  Rapid_Example
//
//  Created by infiq on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import Rapid

struct  TestCellModel {
    let title: String
    let desc: String
}

class TestCell: UITableViewCell {
    
}

extension TestCell: Updatable, Cellable {
    
    static func isXib() -> Bool {
        return true
    }
    
    typealias ViewModel = TestCellModel
    
    func update(_ viewModel: TestCell.ViewModel?) {
        self.textLabel?.text = viewModel?.title
        self.detailTextLabel?.text = viewModel?.desc
    }
    
}
