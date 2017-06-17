//
//  MDTableModel.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit


public enum TableRowInitalType{
    case xib(xibName:String)
    case code(className:UITableViewCell.Type)
}

public protocol TableRow {
    var rowHeight: CGFloat {get}
    var reuseIdentifier: String{get}
    var initalType: TableRowInitalType{get}
    
    //These are optional
    var estimatedHeighAt:(UITableView,IndexPath) -> CGFloat {get}
    var cellForRowAt:(UITableView, IndexPath) -> UITableViewCell {get}
    var indentationLevelForRowAt:(UITableView, IndexPath) -> Int {get}
    var willDisplay:(UITableView,UITableViewCell,IndexPath)->Void{get}
    var didEndDisplaying:(UITableView,UITableViewCell,IndexPath)->Void{get}
    var accessoryButtonTappedForRowWith:(UITableView, IndexPath) -> Void{get}
    var willSelectedRowAt:(UITableView, IndexPath) -> IndexPath?{get}
    var willDeselectedRowAt:(UITableView, IndexPath) -> IndexPath?{get}
    var didSelectRowAt:(UITableView,IndexPath)->Void {get}
    var didDeselectRowAt:(UITableView,IndexPath)->Void {get}
    
    var shouldHighlight: Bool {get}
    var didHighlightRowAt:(UITableView,IndexPath)->Void {get}
    var didUnhighlightRowAt:(UITableView,IndexPath)->Void {get}
}

extension TableRow{
    public var cellStyle: UITableViewCellStyle {
        return .default
    }

    public var estimatedHeighAt:(UITableView,IndexPath) -> CGFloat{
        return { (_,_) in
            return UITableViewAutomaticDimension
        }
    }
    public var cellForRowAt:(UITableView, IndexPath) -> UITableViewCell{
        return { (tableView, indexPath) in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier){
                if let cell = cell as? SystemTableViewCell{
                    cell.render(with: self)
                }
                return cell;
            }else{
                switch self.initalType{
                case .code(let cellClass):
                    let cell = cellClass.init(style: self.cellStyle, reuseIdentifier: self.reuseIdentifier)
                    if let cell = cell as? SystemTableViewCell{
                        cell.render(with: self)
                    }
                    return cell
                case .xib(let xibName):
                    let nib = UINib(nibName: xibName, bundle: Bundle.main)
                    tableView.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
                    let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier)
                    if let cell = cell as? SystemTableViewCell{
                        cell.render(with: self)
                    }
                    return cell!
                }
            }
        }
    }
    public var indentationLevelForRowAt:(UITableView, IndexPath) -> Int{
        return { (tableView, indexPath) in
            return 0
        }
    }
    public var willDisplay:(UITableView,UITableViewCell,IndexPath)->Void{
        return {_,_,_ in }
    }
    public var didEndDisplaying:(UITableView,UITableViewCell,IndexPath)->Void{
        return {_,_,_ in }
    }
    public var accessoryButtonTappedForRowWith:(UITableView, IndexPath)->Void{
        return {_,_ in }
    }
}

// MARK: - Select

extension TableRow{
    public var willSelectedRowAt:(UITableView, IndexPath) -> IndexPath?{
        return { (_, indexPath) in
            return indexPath
        }
    }
    public var willDeselectedRowAt:(UITableView, IndexPath) -> IndexPath?{
        return { (_, indexPath) in
            return indexPath
        }
    }
    public var didSelectRowAt:(UITableView,IndexPath)->Void {
        return { (_, _) in}
    }
    public var didDeselectRowAt:(UITableView,IndexPath)->Void {
        return { (_, _) in}
    }
}
// MARK: - Highlight

extension TableRow{
    public var shouldHighlight: Bool {
        return true
    }
    public var didHighlightRowAt:(UITableView,IndexPath)->Void {
        return { (_, _) in}
    }
    public var didUnhighlightRowAt:(UITableView,IndexPath)->Void {
        return { (_, _) in}
    }
}

