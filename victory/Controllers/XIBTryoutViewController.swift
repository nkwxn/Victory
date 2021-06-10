//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class XIBTryoutViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tryoutView = TimelineView(frame: containerView.frame)
        containerView.addSubview(tryoutView)
        
    }

}
