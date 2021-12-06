//
//  DownloadViewController.swift
//  AnimateMe
//
//  Created by Andres Gutierrez on 12/5/21.
//

import UIKit
import Lottie

class DownloadViewController: UIViewController{
    
    @IBOutlet weak var animationView: AnimationView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.loopMode = .loop
        animationView.play()
        
    }
    
    
}
