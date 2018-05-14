//
//  Section.swift
//  Freedom
//
//  Created by infiq on 2018/1/31.
//  Copyright © 2018年 asynclog. All rights reserved.
//

import UIKit

public class Section {
    public var title: String?
    
    public var headerView: UIView?
    public var headerViewHeight: CGFloat = UITableViewAutomaticDimension
    
    public var footerView: UIView?
    public var footerViewHiehgt: CGFloat = UITableViewAutomaticDimension

    public var rows = [RowType]()
    
    public init() {
        
    }
}
