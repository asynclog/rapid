//
//  Section.swift
//  Freedom
//
//  Created by infiq on 2018/1/31.
//  Copyright © 2018年 asynclog. All rights reserved.
//

import UIKit

public typealias SectionTitleClosure = () -> (String?)
public typealias SectionViewClosure = () -> (UIView?)
public typealias SectionViewHeightClosure = () -> (CGFloat)

public class Section {
    public var titleClosure: SectionTitleClosure?
    
    public var headerViewClosure: SectionViewClosure?
    public var headerViewHeightClosure: SectionViewHeightClosure = Section.defaultHeightClosure
    
    public var footerViewClosure: SectionViewClosure?
    public var footerViewHiehgtClosure: SectionViewHeightClosure = Section.defaultHeightClosure

    public var rows = [RowType]()
    
    public init() {
        
    }
    
    
}

extension Section {
    internal final class func defaultHeightClosure() -> CGFloat {
        return  CGFloat.leastNormalMagnitude
    }
}
