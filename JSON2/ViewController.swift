//
//  ViewController.swift
//  JSON2
//
//  Created by mac on 18/06/19.
//  Copyright © 2019 gammastack. All rights reserved.
//

import UIKit

struct jsonData: Decodable {
    let userId: Int
    let id: Int
    let body: String
    let title: String
}

//struct jsonData: Codable {
//    let userID, id: Int
//    let title, body: String
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case id, title, body
//    }
//}

class ViewController: UIViewController {

    var arrayOfData = [jsonData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func getButtonTapped(_ sender: Any) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do { if error == nil {
                self.arrayOfData = try JSONDecoder().decode([jsonData].self, from: data!)
                for array in self.arrayOfData {
                    print(array.userId, ":", array.id, ":", array.title, ":", array.body )
              }
                }
            } catch {
                print("Error")
            }
        }.resume()
}
    
    @IBAction func pushButtonTapped(_ sender: Any) {
        let parameters = ["username": "Shubhanshu", "comment": "This is good"]
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        urlRequest.httpBody = httpBody
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
//            do { if error == nil {
//                self.arrayOfData = try JSONDecoder().decode([jsonData].self, from: data!)
//                for array in self.arrayOfData {
//                    print(array.userId, ":", array.id, ":", array.title, ":", array.body )
//                }
//                }
//            } catch {
//                print("Error")
//            }
            }.resume()
    }
}

