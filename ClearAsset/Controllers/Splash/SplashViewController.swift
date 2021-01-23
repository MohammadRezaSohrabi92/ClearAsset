//
//  SplashViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 18/01/2021.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        let checkMarkAnimation =  AnimationView(name: "44373-girl-cycling")
        animationView.contentMode = .scaleAspectFit
        self.animationView.addSubview(checkMarkAnimation)
        checkMarkAnimation.frame = self.animationView.bounds
        checkMarkAnimation.loopMode = .loop
        checkMarkAnimation.play()
    }    
    
}
