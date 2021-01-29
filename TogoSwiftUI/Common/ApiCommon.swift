//
//  ApiCommon.swift
//  TogoSwiftUI
//
//  Created by WBCVN on 1/15/21.
//

import SwiftUI

var URL_BASE = "http://localhost:8080/"

struct ApiModel: Codable  {
    let id: Int
    let content: String
}

//func loadData(urlParam: String){
//    guard let url = URL(string: URL_BASE + urlParam) else {
//                print("Your API end point is Invalid")
//                return
//            }
//    let request = URLRequest(url: url)
//    
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//            if let response = try? JSONDecoder().decode(ApiModel.self, from: data) {
//                DispatchQueue.main.async {
//                    return response
//                }
//                return
//            }
//        }
//    }.resume()
//}


