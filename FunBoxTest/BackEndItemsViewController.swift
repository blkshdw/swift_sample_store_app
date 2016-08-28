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
                }
                destination.shopItem = shopItem

            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopItems.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BackEndItemCell", forIndexPath: indexPath) as! BackEndItemCell
        
        cell.titleLabel.text = shopItems[indexPath.row].title
        
        cell.amountLabel.text = shopItems[indexPath.row].displayAmount

        return cell
    }

}
