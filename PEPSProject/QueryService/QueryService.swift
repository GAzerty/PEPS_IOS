//
//  QueryService.swift
//  PEPSProject
//
//  Created by user164567 on 2/29/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class QueryService {
    
    //url: String
    //httpMethod: String (GET,POST,PUT,DELETE)
    //httpBody: Data? (JSON data to send or nil if it's not required)
    func request(url: String, httpMethod: String, httpBody: Data?) -> [String:Any]?{
        
        var result : [String:Any]?
        print(url)
        if let urlAPI = URL(string: url){
            
            var request : URLRequest = URLRequest(url: urlAPI)
            request.httpMethod = httpMethod
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if let httpBody = httpBody {
                request.httpBody = httpBody
            }
            let group = DispatchGroup()
            group.enter()
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("HttpResponse Error")
                    return
                }
                
                
                //Verification du Status Code
                if !(200...299).contains(httpResponse.statusCode) {
                    print("Response Status Code: "+String(httpResponse.statusCode))
                }
                
                //Verification des donnees
                guard let data = data else {
                    print("Data receive not conform")
                    return
                }
                
                //Serialisation en JSON des donnees reçues
                guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]) else {
                    print("JSON Serialization error")
                    return
                }
                
                if let dictionnaryData = jsonObj as? [String:Any]{
                    //print(dictionnaryData)
                    result = dictionnaryData
                }
                group.leave()
                
            }.resume()
            group.wait()
        }
        return result
    }
}
