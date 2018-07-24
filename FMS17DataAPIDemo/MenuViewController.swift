//
//  MenuViewController.swift
//  FMS17DataAPIDemo
//
//  Created by Art Sevilla on 7/9/18.
//  Copyright © 2018 Art Sevilla. All rights reserved.
//

import UIKit

var jsonList: Dictionary<String, AnyObject>?
var layouts: Array<Dictionary<String, AnyObject>>?
var optionsList = ["Home", "Accounts", "Contacts", "Estimates", "Invoices", "Projects", "Products", "Other Modules..."]
var otherModules = ["Preferences", "Staff", "Expenses", "Assets", "Timesheets", "Tasks", "Documents", "Calendar (not working)"]


class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "Layouts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    jsonList = jsonResult
                    layouts = jsonList!["Layouts"] as? Array<Dictionary<String, AnyObject>>
                    print(jsonList as Any)
                    print("Layouts from array: \(layouts as Any)")
                }
            } catch {
                print("Something went wrong with loading the json file...")
            }
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        self.title = "FMSP Options"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (doneOptions))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return layouts!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let item = layouts![indexPath.row]
        print("Cell item \(item as Any)")
        // Configure the cell...
        
        cell.textLabel?.text = item["key"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = layouts![indexPath.row]
        
        print("Did select the item \(item) at index path \(indexPath.row)")
        
//        if indexPath.row == optionsList.count - 1 {
//            print("Last cell was chosen...")
////            let alert = UIAlertController(title: "Alert", message: "You have selected \"Other Modules\"", preferredStyle: .alert)
////            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
////            self.present(alert, animated: true, completion: nil)
//            optionsList.remove(at: indexPath.row)
//            optionsList.append(contentsOf: otherModules)
//            tableView.reloadData()
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Button Actions
    
    @objc func doneOptions() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
