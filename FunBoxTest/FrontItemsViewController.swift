//
//  FirstViewController.swift
//  FunBoxTest
//
//  Created by Алексей on 25.07.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import UIKit
import RealmSwift

class FrontItemsViewController: UIPageViewController {
    var shopItems: Results<ShopItem> {
        get {
            return uiRealm.objects(ShopItem).filter("amount > %@", 0).sorted("title")
        }
    }
    
    var notificationToken: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([viewControllerForIndex(0)], direction: .Forward, animated: false, completion: nil)

        dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func viewControllerForIndex(index: Int) -> UIViewController {
        
        if index < shopItems.count && index >= 0 {
            let newItemController = storyboard?.instantiateViewControllerWithIdentifier("FrontendItemViewController") as! FrontendItemViewController
            
            newItemController.shopItem = shopItems[index]
            newItemController.itemIndex = index
            
            newItemController.itemIsEmptyHandler = { [weak self] index in
                
                var newIndex = 0
                var direction: UIPageViewControllerNavigationDirection = .Forward
                
                if let index = index where index < self?.shopItems.count {
                    newIndex = index
                } else {
                    if let count = self?.shopItems.count {
                        newIndex = count - 1
                    }
                    direction = .Reverse
                    
                }
                
                if let newViewController = self?.viewControllerForIndex(newIndex) {
                    self?.setViewControllers([newViewController], direction: direction, animated: true, completion: nil)
                }
                
            }
            
            return newItemController
        }
        
        let newItemController = storyboard?.instantiateViewControllerWithIdentifier("BlankViewController")

        return newItemController!
    }

}


// MARK: UIPageViewControllerDataSource

extension FrontItemsViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let oldItemViewController = viewController as? FrontendItemViewController {
            if let itemIndex = oldItemViewController.itemIndex where itemIndex > 0 {
                return viewControllerForIndex(itemIndex - 1)
            }
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let oldItemViewController = viewController as? FrontendItemViewController {
            if let itemIndex = oldItemViewController.itemIndex where itemIndex < shopItems.count - 1 {
                return viewControllerForIndex(itemIndex + 1)
            }
        }
        
        return nil
    }
    
    
}
