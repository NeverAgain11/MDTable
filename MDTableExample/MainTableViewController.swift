//
//  MainTableViewController.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class MainTableViewController: UITableViewController {

    var tableManager:TableManager?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let rowClickAction:(UITableView,IndexPath,UIViewController.Type)->Void = { (tableView, indexPath, controllerClass) in
            tableView.deselectRow(at: indexPath, animated: true)
            let tvc = controllerClass.init()
            self.navigationController?.pushViewController(tvc, animated: true)
        }
        // Section 0
        let row0_0 = SystemRow(title: "System Cell", accessoryType: .disclosureIndicator)
        let row0_1 = SystemRow(title: "Dynamic Height", accessoryType: .disclosureIndicator)
        let row0_2 = SystemRow(title: "Custom Cell with XIB", accessoryType: .disclosureIndicator)
        let row0_3 = SystemRow(title: "Complex(TODO)", accessoryType: .disclosureIndicator)
        let section0Controllers:[UIViewController.Type] = [SystemCellUsageController.self,
                                   CustomCellWithCodeController.self,
                                   CustomCellWithXibController.self,
                                   ComplexTableViewController.self]
        let rows_0 = [row0_0, row0_1, row0_2, row0_3]
        zip(rows_0, section0Controllers).forEach {
            let (row, controller) = $0
            row.onDidSelected({ (tableView, indexPath) in
                rowClickAction(tableView, indexPath, controller)
            })
        }
        let section0 = SystemSection(rows: rows_0)
        section0.titleForHeader = "Basic"
        
        //Section 1
        let row1_0 = SystemRow(title: "Swpite to delete", accessoryType: .disclosureIndicator)
        let row1_1 = SystemRow(title: "Reorder", accessoryType: .disclosureIndicator)
        let row1_2 = SystemRow(title: "Index Title", accessoryType: .disclosureIndicator)
        
        let section1Controllers:[UIViewController.Type] = [SwipteToDeleteController.self,
                                   ReorderTableViewController.self,
                                   SectionIndexTitleController.self]
        let rows_1 = [row1_0,row1_1,row1_2]
        zip(rows_1, section1Controllers).forEach {
            let (row, controller) = $0
            row.onDidSelected({ (tableView, indexPath) in
                rowClickAction(tableView, indexPath, controller)
            })
        }
        let section1 = SystemSection(rows: rows_1)
        section1.titleForHeader = "Advanced"

        tableManager = TableManager(sections: [section0,section1])
        tableView.md_bindTo(manager: tableManager!)
    }

}

