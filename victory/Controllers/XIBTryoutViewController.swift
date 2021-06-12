//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

protocol PopUpDelegate: AnyObject {
    func showSkorView()
}

class XIBTryoutViewController: UIViewController, PopUpDelegate {
    
    @IBOutlet weak var kontenKuisView: KontenKuisView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kontenKuisView.delegate = self
    
    }
    
    func showSkorView() {
        print ("yey")
    }
    
}
