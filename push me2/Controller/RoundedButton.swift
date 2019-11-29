//
//  RoundedButton.swift
//  push me2
//
//  Created by daniel.d4 on 08/02/2019.
//  Copyright © 2019 daniel.d4. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
    }

}
