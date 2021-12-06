//
//  ViewController.swift
//  AnimateMe
//
//  Created by Andres Gutierrez on 12/5/21.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "dance")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
        animationView?.play()
        
    }


}

