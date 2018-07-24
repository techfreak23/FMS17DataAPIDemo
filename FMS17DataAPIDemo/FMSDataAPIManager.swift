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
    static let sharedManager = APIManager(host:"https://techfreak23.hopto.org/fmi/data/v1/databases/", application:"FM_Starting_Point_602use")
    
    private var host: String = ""
    private var application: String = ""
    private var username: String = "api"
    private var password: String = "Spock420"
    private var accessToken: String = ""
    private var currentLayout: String = ""
    private var authenticated = false
    private var menuItems: Array = [Dictionary<String,String>]()
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "test.example.com": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: false,
                validateHost: false
            ),
            "techfreak23.hopto.org": .disableEvaluation
        ]
        
        return SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    
    //MARK: - Designated Initializer
    private init(host:String, application:String) {
        print("API Network Manager has been initialized with session manger \(sessionManager)")
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
    
    var currentSetLayout: String {
        return currentLayout
    }
    
    private func sendRequest(method:String, endpoint:String, params:[String:AnyObject]? = nil, headers:[String:String]? = nil ) {
        switch method {
        case "POST":
            sessionManager.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {response in
                debugPrint(response); print("Response from completion block: \(response)")})
            
        case "PATCH":
            sessionManager.request(endpoint, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {response in
                debugPrint(response); print("Response from the completion block PATCH: \(response)")
            })
        case "DELETE":
            sessionManager.request(endpoint, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {response in
                debugPrint(response); print("Response from the completion block DELETE: \(response)")
            })
        default:
            sessionManager.request(endpoint, method: .get, headers: headers).responseJSON(completionHandler: {response in
                debugPrint(response); print("Response from the completion block GET: \(response)")
            })
        }
    }
    
    func setCurrentLayout(layout:String) {
        self.currentLayout = layout
    }
    
    func loginToFile() {
        let loginPath = host + application + "/sessions"
        let headers = [ "Content-Type": "application/json", "Authorization":"Bearer YXBpOlNwb2NrNDIw"]
        
        sendRequest(method: "POST", endpoint: loginPath, params: nil, headers: headers)
    }
    
    func logoutOfFile(completion: (@escaping (DataResponse<Any>) -> Void) -> Void) {
        
    }
    
    func uploadToContainerField() {
        
    }
    
    func listRecords() {
        
    }
    
    func createRecord() {
        
    }
    
    func getRecord() {
        
    }
    
    func updateRecord() {
        
    }
    
    func removeRecord() {
        
    }
    
    func performFind() {
        
    }
    
    func setGlobalFields() {
        
    }
    
    
    
}
