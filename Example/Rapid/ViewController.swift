//
//  ViewController.swift
//  Rapid
//
//  Created by infiniteQin on 05/11/2018.
//  Copyright (c) 2018 infiniteQin. All rights reserved.
//

import UIKit
import Rapid

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = RapidTableView.view(frame: view.bounds, style: .plain)
//        tableView.registNib(cellClass: TestCell.self)
//        tableView.registCell(cellClass: TestCell.self)
        let section = Section()
        let row = Row<TestCell>(height: 100, viewModel: TestCellModel(title: "title", desc: "desc"))
        row.selectAction = { (_ row: RowType) in
            print("did select")
        }
        section.rows.append(row)
        tableView.addSections([section])
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

