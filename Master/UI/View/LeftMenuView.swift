//
//  CategoryView.swift
//  Master
//
//  Created by Gürsu Aşık on 27.07.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var data: HomePageBanner
}

class LeftMenuView: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    @IBOutlet weak var categorysTable: UITableView!
    
    var tableViewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for leftMenuItem in (homePage?.data.leftMenu)! {
            tableViewData.append(cellData(opened: false, data: leftMenuItem))
        }
        
        //categorysTable.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeader")
        
        //categorysTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableViewData[section].data.parentFields.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        cell.name.text = tableViewData[indexPath.section].data.parentFields[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        revealViewController().revealToggle(animated: false)

        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "productsId") as! ProductsViewController
        viewController.Url = tableViewData[indexPath.section].data.parentFields[indexPath.row].value
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableViewData[indexPath.section].opened) {
            return 44
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableViewData[section].data.parentFields.count == 0 {
            let row = UITableViewHeaderFooterView()
            row.textLabel?.font = UIFont(name: "Gotham", size: 13)
            //row.textLabel?.font = row.textLabel?.font.withSize(13)
            row.textLabel?.text = tableViewData[section].data.field.name
            row.tag = section
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            row.addGestureRecognizer(tapRecognizer)
            
            return row
        }
        else {
            let row = ExpandableHeaderView()
            row.customInit(title: "+ " + tableViewData[section].data.field.name, section: section, delegate: self)
            
            return row
            
            /*let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
            
            headerView.customLabel.text = tableViewData[section].data.field.name  // set this however is appropriate for your app's model
            headerView.section = section
            headerView.delegate = self
            
            return headerView*/
        }
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer){
        revealViewController().revealToggle(animated: false)
        
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        //let viewController = storyboard.instantiateInitialViewController()! as! ProductsViewController
        let viewController = storyboard.instantiateViewController(withIdentifier: "productsId") as! ProductsViewController//Navigation Controller
        viewController.Url = tableViewData[(gestureRecognizer.view?.tag)!].data.field.value
        let navigationController = UINavigationController(rootViewController: viewController)//Navigation Controller
        //self.present(viewController, animated: true, completion: nil)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    /*func toggleSection(header: ExpandableHeaderView, section: Int){
        tableViewData[section].opened = !tableViewData[section].opened
        
        categorysTable.beginUpdates()
        for i in 0..<tableViewData[section].data.parentFields.count {
            categorysTable.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        categorysTable.endUpdates()
    }*/
    
    func toggleSection(header: ExpandableHeaderView, section: Int){
        tableViewData[section].opened = !tableViewData[section].opened
        
        categorysTable.beginUpdates()
        for i in 0..<tableViewData[section].data.parentFields.count {
            categorysTable.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        categorysTable.endUpdates()
    }
}
