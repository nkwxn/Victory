//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class XIBTryoutViewController: UIViewController {
    
    @IBOutlet weak var containerView: TimelineView!
    @IBOutlet weak var onBoardingView: OnBoardingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.materiPill.layer.cornerRadius = 14
        containerView.materiPill.backgroundColor = UIColor.black
        
        onBoardingView.layer.cornerRadius = 13
        onBoardingView.layer.masksToBounds = true
        onBoardingView.actionBtn.layer.cornerRadius = 8
        
    }

}
