//
//  MDTable.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import ObjectiveC

struct MDTableConst{
    static let associatedKey = UnsafeRawPointer.init(bitPattern: "MDTableAccessoryKey".hashValue)
}
public extension UITableView{    
    var manager:TableManager?{
        get {
            guard let associatedKey = MDTableConst.associatedKey else { return nil }
            return objc_getAssociatedObject(self, associatedKey) as? TableManager
        } set {
            asyncExecuteOnMain {
                newValue?.bindTo(tableView: self)
                guard let associatedKey = MDTableConst.associatedKey else { return }
                objc_setAssociatedObject(self, associatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
