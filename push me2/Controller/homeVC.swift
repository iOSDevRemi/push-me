//
//  homeVC.swift
//  push me2
//
//  Created by daniel.d4 on 08/02/2019.
//  Copyright © 2019 daniel.d4. All rights reserved.
//

import UIKit
import Lottie


class homeVC: UIViewController {
    
    //Outlets
  
    @IBOutlet weak var animatedView: LOTAnimationView!
    @IBOutlet weak var animetedView: LOTAnimationView!
    
    
    
    //Variables
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        startAnimation2()

        // Do any additional setup after loading the view.
    }
    
    func startAnimation2() {
        animetedView.setAnimation(named: "3807")
        animetedView.loopAnimation = true
        animetedView.play()
    }
    
    func startAnimation() {
        animatedView.setAnimation(named: "dead")
        animatedView.loopAnimation = true
        animatedView.play()
    }
  

}
