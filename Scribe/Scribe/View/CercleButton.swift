//
//  CercleButton.swift
//  Scribe
//
//  Created by daniel.d4 on 15/04/2019.
//  Copyright © 2019 daniel.d4. All rights reserved.
//

import UIKit

@IBDesignable
class CercleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
           setUpView()
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }

    func setUpView() {
         layer.cornerRadius = cornerRadius
    }
    
    
}
