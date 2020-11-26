//
//  ViewClaimGenerator.swift
//  Claim iOS View Programming
//
//  Created by Shane Wilson on 11/25/20.
//

import UIKit

class ViewClaimGenerator {
    var root : UIView!
    var vals : [UITextField]!
    var sendBtn : UIButton!
    var completeStackView : UIStackView!
    
    init(v : UIView) {
        root = v
    }
    
    func setViewReference() {
        vals = [UITextField]()
        
        //
        for sv in completeStackView.arrangedSubviews {    // 3 of them
            
            if sv is UILabel {
                continue
            }
            
            let innerStackView = sv as! UIStackView
            for ve in innerStackView.arrangedSubviews { // 2 of them
                if ve is UITextField {
                    vals.append(ve as! UITextField)
                }
                if ve is UIButton {
                    let btn = ve as! UIButton
                    if btn.titleLabel?.text == "Add" {
                        sendBtn = btn
                    }
                }
            }

        }
    }

    func generate() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        
        let lbl = UILabel()
        lbl.text = "Please Enter Claim Information"
        lbl.textAlignment = .center
        lbl.sizeToFit()
        lbl.font = .boldSystemFont(ofSize: 20)
        stackView.addArrangedSubview(lbl)
        
        var fvGenerator : FieldValueViewClaimGenerator!
        var sView : UIStackView!
        fvGenerator = FieldValueViewClaimGenerator(n:"Claim Title", v: "")
        sView = fvGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        fvGenerator = FieldValueViewClaimGenerator(n:"Date", v: "")
        sView = fvGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        let btnGenerator = ButtonViewClaimGenerator(n: "Add")
        sView = btnGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        fvGenerator = FieldValueViewClaimGenerator(n:"Status:", v: "<Status Message>", readOnly: true)
        sView = fvGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        completeStackView = stackView
        root.addSubview(stackView)
        
        setViewReference()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let spCnt1 = stackView.topAnchor.constraint(equalToSystemSpacingBelow: root.safeAreaLayoutGuide.topAnchor, multiplier: 25)
        //equalTo: root.safeAreaLayoutGuide.topAnchor
        let spCnt2 = stackView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: root.safeAreaLayoutGuide.leadingAnchor, multiplier: 5)
        //equalTo: root.safeAreaLayoutGuide.leadingAnchor
        let spCnt3 = stackView.bottomAnchor.constraint(equalTo: root.safeAreaLayoutGuide.bottomAnchor)
        //equalTo: root.safeAreaLayoutGuide.bottomAnchor
        let spCnt4 = stackView.trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: root.safeAreaLayoutGuide.trailingAnchor, multiplier: 5)
        //equalTo: root.safeAreaLayoutGuide.trailingAnchor
        spCnt1.isActive = true
        spCnt2.isActive = true
        spCnt3.isActive = false
        spCnt4.isActive = true
    }
}


class FieldValueViewClaimGenerator {
    var lblName : String!
    var initVal : String!
    var readOnlyState : Bool!
    
    init(n : String, v : String, readOnly : Bool = false) {
        lblName = n
        initVal = v
        readOnlyState = readOnly
    }
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        //
        let lbl = UILabel()
        lbl.text = lblName
        lbl.sizeToFit()
        stackView.addArrangedSubview(lbl)
        let val = UITextField()
        val.text = initVal
        val.borderStyle = .roundedRect
        val.backgroundColor = UIColor.lightGray
        stackView.addArrangedSubview(val)
        
        if (readOnlyState) {
            val.isUserInteractionEnabled = false
        }
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        // Expand
        lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        val.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stackView
    }
}


class ButtonViewClaimGenerator {
    var lblName : String!
    
    init(n : String) {
        lblName = n
    }
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        
        //
        let btn = UIButton()
        btn.setTitle(lblName, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.systemRed
        
        stackView.addArrangedSubview(btn)
        
        return stackView
    }
}
