
//
//  FrontendItemViewController.swift
//  FunBoxTest
//
//  Created by Алексей on 23.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import UIKit
import RealmSwift

class FrontendItemViewController: UITableViewController {
    
    var shopItem : ShopItem? = nil {
        didSet {
            if shopItem != nil {
            }

        }
    }
    var itemIndex: Int? = nil
    
    var itemObserver: NSObjectProtocol? = nil
        
    @IBAction func buyTouchedHandler(sender: AnyObject) {
        if let shopItem = self.shopItem {
            ShopDataManager.instance.buyItem(shopItem)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    var itemIsEmptyHandler: ((Int?) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        if shopItem?.amount == 0 {
            itemIsEmptyHandler?(itemIndex)
        }
        titleLabel.text = shopItem?.title
        priceLabel.text = shopItem?.displayPrice
        amountLabel.text = shopItem?.displayAmount
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
                
        itemObserver = NSNotificationCenter.defaultCenter().addObserverForName(
            OBJECT_CHANGED,
            object: nil, queue: nil,
            usingBlock: dataChangedHandler)
        
        reloadData()
    }
    
    func dataChangedHandler(notification: NSNotification) {
        if let objectId = notification.object as? String where objectId == shopItem?.id {
            self.reloadData()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let observer = self.itemObserver {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
    }
    

}
