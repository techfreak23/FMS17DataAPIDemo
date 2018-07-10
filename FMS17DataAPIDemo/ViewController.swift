//
//  ViewController.swift
//  FMS17DataAPIDemo
//
//  Created by Art Sevilla on 7/9/18.
//  Copyright © 2018 Art Sevilla. All rights reserved.
//

import UIKit

var menuView: MenuViewController?
// var collectionOptions = ["Accounts", "Contacts", "Estimates", "Invoices", "Projects", "Products"]
// var myCollection: UICollectionView?

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if myCollection == nil {
//            myCollection = UICollectionView()
//        }
        
        // myCollection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        
        
        self.title = "Hello World"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(showMenu))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func showMenu() {
        print("Menu was pressed...")
        
        if menuView == nil {
            menuView = MenuViewController()
            
        }
        
        let navController = UINavigationController(rootViewController: menuView!)
        
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func navigateToModule (_ moduleName: String) {
        switch moduleName {
        case "Home":
            print("Home was selected...")
            //do something..
        default:
            print("Do nothing here....")
        }
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)
        
        
        
        return cell
    }
    
    // MARK: - Collection View Delegate Methods
    
    
    
}

