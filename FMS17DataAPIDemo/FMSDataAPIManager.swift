//
//  FMSDataAPIManager.swift
//  FMS17DataAPIDemo
//
//  Created by Art Sevilla on 7/21/18.
//  Copyright © 2018 Art Sevilla. All rights reserved.
//

import Foundation
import Alamofire 

public class APIManager {
    //MARK: - Private Properties
    static let sharedManager = APIManager(host:"https://techfreak23.hopto.org/fmi/data/v1/databases", application:"FM_Starting_Point_602use")
    
    private var host: String = ""
    private var application: String = ""
    private var username: String = "api"
    private var password: String = "Spock420"
    private var accessToken: String = ""
    private var currentLayout: String = ""
    private var authenticated = false
    private var menuItems: Array = [Dictionary<String,String>]()
    
    
    //MARK: - Designated Initializer
    private init(host:String, application:String) {
        print("API Network Manager has been initialized...")
        self.host = host
        self.application = application
        if let path = Bundle.main.path(forResource: "Layouts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, [Dictionary<String,String>]> {
                    menuItems = jsonResult["Layouts"]!
                    currentLayout = menuItems[0]["value"]!
                    print("Menu items from init:\n\(menuItems)")
                }
            } catch {
                print("Something went wrong with loading the json file...")
            }
        }
    }
    
    //MARK: - Public Properties/Methods
    //var layoutList = 
    
    var description: String {
        return "Manager initialized with host \(self.host) and file \(self.application). Current layout: \(self.currentLayout)."
    }
    
    var menuItemList: String {
        return "The menu items are here: \(menuItems)"
    }
    
    func setCurrentLayout(layout:String) {
        self.currentLayout = layout
    }
}
