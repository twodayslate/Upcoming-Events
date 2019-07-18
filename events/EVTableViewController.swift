//
//  ViewController.swift
//  events
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import UIKit

/**
 A simple event viewer for Facebook events
 Each conflicting event is marked with a check
 */
final class EVTableViewController: UITableViewController {

    var manager: EventManager? = {
        return EventManager(withJsonResourceName: "mock")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Facebook.white
        self.title = "Facebook Events"
        
        self.setEventNavigationBarStyle()
    }
}

// MARK: - UITableViewDataSource
extension EVTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionKey = manager?.sortedKeys[section] else {
            return 0
        }
        return manager?.events[sectionKey]?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return manager?.events.keys.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.description)
        cell.selectionStyle = .none
        
        guard let sectionKey = manager?.sortedKeys[indexPath.section] else {
            return cell
        }
        
        guard let event = manager?.events[sectionKey]?[indexPath.row] else {
            return cell
        }
        
        cell.textLabel?.text = event.title
        
        if event.conflicts {
            cell.accessoryType = .checkmark
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        cell.detailTextLabel?.text = formatter.string(from: event.startDate) + " - " + formatter.string(from: event.endDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionKey = manager?.sortedKeys[section] else {
            return nil
        }
        guard let date = Calendar.current.date(from: sectionKey) else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        
        return formatter.string(from: date)
    }
}
