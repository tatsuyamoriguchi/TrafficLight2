//
//  TrafficLightTableViewController.swift
//  TrafficLight
//
//  Created by Tatsuya Moriguchi on 7/2/22.
//

import UIKit
import CoreData


class TrafficLightTableViewController: UITableViewController {

    let access = AccessData()
    


    override func viewWillAppear(_ animated: Bool) {
        access.getAllItems()
    }
    
    @IBAction func deleteAllButton(_ sender: Any) {
        access.deleteAllItems()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return access.models.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = access.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.event
        
        var timeString: String = ""
        if model.time != nil {
            timeString = Helper().date2String(date: model.time!)
        } else {
            timeString = "No time data available"
        }
        cell.detailTextLabel?.text = timeString


        return cell
    }

}
