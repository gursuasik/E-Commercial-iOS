//
//  FilterViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 17.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var searchResult: SearchResult?
    var filters = [Filter]()
    var s = ""
    var t = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.tableFooterView = UIView()
        
        filters = [Filter(opened: false, sectionName: "Sırala", filterSection: [FilterSection(name: "Artan fiyat", value: "1"), FilterSection(name: "Azalan fiyat", value: "4"), FilterSection(name: "En yeniler", value: "21"), FilterSection(name: "En çok satan", value: "8"), FilterSection(name: "A'dan Z'ye", value: "9"), FilterSection(name: "Öne çıkan", value: "5")])]
        
        for group in (searchResult?.data.tagGroup)! {
            var filterSection = [FilterSection?]()
            
            for list in group.list {
                filterSection.append(FilterSection(name: list.name!, value: list.id))
            }
            
            filters.append(Filter(opened: false, sectionName: group.name!, filterSection: filterSection as! [FilterSection]))
        }
        
        for group in (searchResult?.data.specGroup)! {
            var filterSection = [FilterSection?]()
            
            for list in group.list {
                filterSection.append(FilterSection(name: list.name!, value: String(list.id)))
            }
            
            filters.append(Filter(opened: false, sectionName: group.name!, filterSection: filterSection as! [FilterSection]))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters[section].filterSection.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let row = ExpandableHeaderView()
        row.customInit(title: filters[section].sectionName!, section: section, delegate: self)
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilterTableViewCell
        
        cell.accessoryType = .none
        cell.name.text = filters[indexPath.section].filterSection[indexPath.row]?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            for i in 0...5 {
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath)
                cell?.accessoryType = .none
                
                tableView.deselectRow(at: indexPath, animated: true)
                
                filters[indexPath.section].filterSection[indexPath.row]?.select = false
            }
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            filters[indexPath.section].filterSection[indexPath.row]?.select = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            
            filters[indexPath.section].filterSection[indexPath.row]?.select = false
        }
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int){
        filters[section].opened = !filters[section].opened
        
        table.beginUpdates()
        for i in 0..<filters[section].filterSection.count {
            table.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        table.endUpdates()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (filters[indexPath.section].opened) {
            return 44
        }
        else {
            return 0
        }
    }
    
    @IBAction func onFilter(_ sender: Any) {
        var oArray = [String]()
        for i in 0...5 {
            if (filters[0].filterSection[i]?.select)! {
                oArray.append((filters[0].filterSection[i]?.value)!)
            }
        }

        var tArray = [String]()
        let tagGroupCount = (searchResult?.data.tagGroup.count)!
        for i in 0..<tagGroupCount {
            let listCount = (searchResult?.data.tagGroup[i].list.count)!
            for j in 0..<listCount {
                if (filters[i + 1].filterSection[j]?.select)! {
                    tArray.append((filters[i + 1].filterSection[j]?.value)!)
                }
            }
        }

        var sArray = [String]()
        let specGroupCount = (searchResult?.data.specGroup.count)!
        for i in 0..<specGroupCount {
            let listCount = (searchResult?.data.specGroup[i].list.count)!
            for j in 0..<listCount {
                if (filters[tagGroupCount + 1].filterSection[j]?.select)! {
                    sArray.append((filters[tagGroupCount + 1].filterSection[j]?.value)!)
                }
            }
        }

        let productsViewController = self.navigationController?.viewControllers[0] as! ProductsViewController
        productsViewController.o = oArray.joined(separator: ", ")
        productsViewController.t = tArray.joined(separator: ", ")
        productsViewController.s = sArray.joined(separator: ", ")
        self.navigationController?.popViewController(animated: true)
    }
}

class Filter {
    var opened: Bool
    var sectionName: String?
    var filterSection: [FilterSection?]
    
    init(opened: Bool, sectionName: String, filterSection: [FilterSection]) {
        self.opened = opened
        self.sectionName = sectionName
        self.filterSection = filterSection
    }
}

class FilterSection {
    var name: String?
    var value: String?
    var select = false
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
