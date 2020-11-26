//
//  ViewController.swift
//  Claim iOS View Programming
//
//  Created by Shane Wilson on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    var claimTitleField: UITextField?
    var claimDateField: UITextField?
    var statusTextField: UITextField?
    
    @objc func sendData(sender: UIButton) {
        //
        let claimService = ClaimService(vc : self)
        let claimTitle = claimTitleField!.text
        let claimDate = claimDateField!.text
        
        let claimObj = Claim(title: claimTitle!, date: claimDate!)
        
        claimService.addClaim(claim: claimObj)
        
        // Reset Form
        claimTitleField!.text = ""
        claimDateField!.text = ""
    }
    
    
    func setStatusField(status: String) {
        statusTextField!.text = status
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewClaimGen = ViewClaimGenerator(v: view)
        
        viewClaimGen.generate()
        
        let sendBtn = viewClaimGen.sendBtn
        claimTitleField = viewClaimGen.vals[0]
        claimDateField = viewClaimGen.vals[1]
        statusTextField = viewClaimGen.vals[2]
        
        
        sendBtn?.addTarget(self, action: #selector(sendData(sender:)), for: .touchUpInside)
    }
    
}

