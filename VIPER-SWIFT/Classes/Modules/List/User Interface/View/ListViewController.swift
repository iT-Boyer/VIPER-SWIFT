//
//  ListViewController.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

var ListEntryCellIdentifier = "ListEntryCell"

class ListViewController : UITableViewController, ListViewInterface {
    var eventHandler : ListModuleInterface?
    var dataProperty : UpcomingDisplayData?
    var strongTableView : UITableView?
    
    @IBOutlet var noContentView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        strongTableView = tableView
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventHandler?.updateView()
    }
    
    func configureView() {
        navigationItem.title = "VIPER TODO"
        
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: Selector("didTapAddButton"))
        
        navigationItem.rightBarButtonItem = addItem
    }
    
    //MARK: - UIAction 抽象接口
    @objc func didTapAddButton () {
        eventHandler?.addNewEntry()
    }
    
    //MARK: - View 接口代理
    func showNoContentMessage() {
        view = noContentView
    }
    
    func showUpcomingDisplayData(data: UpcomingDisplayData) {
        view = strongTableView
        
        dataProperty = data
        reloadEntries()
    }
    
    func reloadEntries() {
        tableView.reloadData()
    }
    //MARK: - tableview 代理
    override func numberOfSections(in tableView: UITableView) -> Int  {
        var numberOfSections = dataProperty?.sections.count
        
        if dataProperty?.sections.count == nil {
            numberOfSections = 0
        }
        
        return numberOfSections!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let upcomingSection = dataProperty?.sections[section]
        return upcomingSection!.items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let upcomingSection = dataProperty?.sections[section]
        return upcomingSection!.name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let upcomingSection = dataProperty?.sections[indexPath.section]
        let upcomingItem = upcomingSection!.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: ListEntryCellIdentifier, for: indexPath as IndexPath) as UITableViewCell

        cell.textLabel!.text = upcomingItem.title;
        cell.detailTextLabel!.text = upcomingItem.dueDate;
        cell.imageView!.image = UIImage(named: upcomingSection!.imageName)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;

        return cell
    }
}
