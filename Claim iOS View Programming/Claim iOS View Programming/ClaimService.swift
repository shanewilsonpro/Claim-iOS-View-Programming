//
//  ClaimService.swift
//  Claim iOS View Programming
//
//  Created by Shane Wilson on 11/25/20.
//


import Foundation

struct Claim : Codable {
    var title : String
    var date : String
    
    init(title: String, date: String) {
        self.title = title
        self.date = date
    }
}

class ClaimService {

    init(vc : ViewController) {
        viewController = vc
    }
    
    var viewController : ViewController
    
    func addClaim(claim: Claim) {
        let requestUrl = "http://localhost:8020/ClaimService/add"
        var request = URLRequest(url: NSURL(string: requestUrl)! as URL)
        let jsonData : Data! = try! JSONEncoder().encode(claim)
        //
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
            (data, response, error) in
            if let resp = data {
                // type of resp is Data
                let respStr = String(bytes: resp, encoding: .utf8)
                print("The response data sent from the server is \(respStr!)")
                OperationQueue.main.addOperation {
                    self.viewController.setStatusField(status: "Claim \(claim.title) was successfully created")
                }
                //
            } else if let respError = error {
                print("Server Error : \(respError)")
                OperationQueue.main.addOperation {
                    self.viewController.setStatusField(status: "Claim \(claim.title) failed to be created")
                }
            }
        }
        task.resume()
    }
}
