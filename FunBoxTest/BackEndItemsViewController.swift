//
//  BackEndItemsViewController.swift
//  FunBoxTest
//
//  Created by Алексей on 24.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import UIKit
import RealmSwift

class BackEndItemsViewController: UITableViewController {
    
    var notificationToken: NotificationToken? = nil
    
    var shopItems: Results<ShopItem> {
        get {
            return uiRealm.objects(ShopItem).sorted("title")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
         notificationToken = shopItems.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.stop()
    }
    
    //MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "selectItem" {
            if let destination = segue.destinationViewController as? BackEndItemViewController,
                itemIndex = tableView.indexPathForSelectedRow?.row {
                destination.shopItem = shopItems[itemIndex]
            }
        } else if segue.identifier == "addItem" {
            if let destination = segue.destinationViewController as? BackEndItemViewController {
                let shopItem = ShopItem()
                try! uiRealm.write {
                    uiRealm.add(shopItem)
                    try! uiRealm.commitWrite()
                    destination.shopItem = shopItem
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shopItems.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BackEndItemCell", forIndexPath: indexPath) as! BackEndItemCell
        
        cell.titleLabel.text = shopItems[indexPath.row].title
        
        cell.amountLabel.text = shopItems[indexPath.row].displayAmount

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
