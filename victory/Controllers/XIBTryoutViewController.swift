//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

protocol PopUpDelegate: AnyObject {
    func mulaiKuisView()
    func showSkorView(totalCorrectAnswer: Int, totalSoalKuis: Int)
    func closeSkorView()
}

class XIBTryoutViewController: UIViewController, PopUpDelegate {
    
    @IBOutlet weak var kontenKuisView: KontenKuisView!
    @IBOutlet weak var skorView: SkorView!
    @IBOutlet weak var onboardingView: OnboardingView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.delegate = self
        kontenKuisView.delegate = self
        skorView.delegate = self
        
        kontenKuisView.isHidden = true
        skorView.isHidden = true
    }
    
    func showSkorView(totalCorrectAnswer: Int, totalSoalKuis: Int) {
        skorView.isHidden = false
        skorView.benarLbl.text = "\(totalCorrectAnswer) / \(totalSoalKuis)"
        skorView.salahLbl.text = "\(totalSoalKuis - totalCorrectAnswer) / \(totalSoalKuis)"
        skorView.scoreLbl.text = "\(totalCorrectAnswer * 20) / \(totalSoalKuis * 20)"
        
    }
    func closeSkorView() {
        skorView.isHidden = true
    }
    func mulaiKuisView() {
        kontenKuisView.isHidden = false
    }
    
}
