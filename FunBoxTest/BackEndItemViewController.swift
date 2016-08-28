//
//  BackEndItemViewController.swift
//  FunBoxTest
//
//  Created by Алексей on 24.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//


import UIKit
import RealmSwift

class BackEndItemViewController: UITableViewController {
    
    var shopItem : ShopItem? = nil
    
    var itemObserver: NSObjectProtocol? = nil
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        saveButton.enabled = false
        view.endEditing(true)
        
        if let item = self.shopItem {
            ShopDataManager.instance.editItem(item) {
                item.title = titleField.text ?? ""
                item.price = Double(priceField.text ?? "") ?? 0
                item.amount = Int(amountField.text ?? "") ?? 0
            }
        }
        reloadData()
    }
    
    
    @IBAction func didBeginEditing(sender: AnyObject) {
        saveButton.enabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        itemObserver =  NSNotificationCenter.defaultCenter().addObserverForName(
            OBJECT_CHANGED,
            object: nil, queue: nil,
            usingBlock: dataChangedHandler)

        reloadData()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let observer = self.itemObserver {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
    }
    
    func dataChangedHandler(notification: NSNotification) {
        if let objectId = notification.object as? String where objectId == shopItem?.id {
            self.reloadData()
        }
    }
    
    func reloadData() {
        titleField.text = shopItem?.title
        priceField.text = shopItem?.priceString
        amountField.text = shopItem?.amountString
        
        navigationItem.title = shopItem?.title

    }

    
}
