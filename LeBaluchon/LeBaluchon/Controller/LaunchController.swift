//
//  LaunchController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 11/10/2021.
//

import UIKit
import SwiftyGif

class LaunchController: UIViewController {

    let logoAnimationView = LogoAnimation()
    
    @IBOutlet weak var startBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        
        setUp()
    }
    
    func setUp() {
        startBTN.layer.cornerRadius = 20
        startBTN.layer.cornerRadius = 20
        startBTN.layer.cornerRadius = 20
        startBTN.layer.shadowColor = UIColor.black.cgColor
        startBTN.layer.shadowOpacity = 0.5
        startBTN.layer.shadowOffset = CGSize(width: 0, height: 20)
        startBTN.layer.shadowRadius = 20
    }

}

extension LaunchController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        
        
        
    }
}
