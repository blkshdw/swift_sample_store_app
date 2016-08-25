
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
    
    var shopItem : ShopItem? = nil
    var itemIndex: Int? = nil
    
    private var myContext = 0
    
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
        shopItem?.addObserver(self, forKeyPath: ShopItem.keyPaths.Title.rawValue, options: NSKeyValueObservingOptions.Initial, context: &myContext)
        shopItem?.addObserver(self, forKeyPath: ShopItem.keyPaths.Price.rawValue, options: NSKeyValueObservingOptions.Initial, context: &myContext)
        shopItem?.addObserver(self, forKeyPath: ShopItem.keyPaths.Amount.rawValue, options: NSKeyValueObservingOptions.Initial, context: &myContext)
    }
    
    deinit {
        shopItem?.removeObserver(self, forKeyPath: ShopItem.keyPaths.Title.rawValue)
        shopItem?.removeObserver(self, forKeyPath: ShopItem.keyPaths.Price.rawValue)
        shopItem?.removeObserver(self, forKeyPath: ShopItem.keyPaths.Amount.rawValue)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = shopItem?.title
        priceLabel.text = shopItem?.displayPrice
        amountLabel.text = shopItem?.displayAmount
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if let keyPath = keyPath {
            switch keyPath {
            case ShopItem.keyPaths.Title.rawValue:
                titleLabel.text = shopItem?.title
                break
            case ShopItem.keyPaths.Price.rawValue:
                priceLabel.text = shopItem?.displayPrice
                break
            case ShopItem.keyPaths.Amount.rawValue:
                if shopItem?.amount == 0 {
                    itemIsEmptyHandler?(itemIndex)
                }
                amountLabel.text = shopItem?.displayAmount
            default:
                break
            }
        }
    }

}
