//
//  XIBTryoutViewController.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

protocol XIBTryoutViewControllerDelegate: class {
    func moveToPanduanView()
    func closePanduanView()
    func changeStep(to step: Step)
}

class XIBTryoutViewController: UIViewController, XIBTryoutViewControllerDelegate {
    
    @IBOutlet weak var timelineView: TimelineView!
    @IBOutlet weak var onBoardingView: OnBoardingView!
    @IBOutlet weak var panduanLabView: PanduanLabView!
    @IBOutlet weak var dimOverlayView: DimOverlayView!
    
    
    @IBAction func onOBButtonPressed(_ sender: Any) {
        showOnBoardingView()
    }
    
    @IBAction func onPanduanBtnPressed(_ sender: Any) {
        showPanduanView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTimelineView()
        setupPanduanLabView()
        setupOnboardingView()
        setupDimOverlayView()
        
        panduanLabView.isHidden = true
        dimOverlayView.isHidden = true
        onBoardingView.isHidden  = true
    }
    /*
    // Delegate Functions
    */
    var currentStep: Step = .materi
    var stepList: [Int] = []
    /*
    // Delegate Functions
    */
    func moveToPanduanView() {
        closeOnBoardingView()
        showPanduanView()
    }
    
    func closePanduanView() {
        panduanLabView.isHidden = true
        dimOverlayView.isHidden = true
    }
    
    func changeStep(to step: Step) {
        switch step {
        case .materi:
            print(step.rawValue)
        case .labOne:
            print(step.rawValue)
        case .labTwo:
            print(step.rawValue)
        case .labThree:
            print(step.rawValue)
        case .kuis:
            print(step.rawValue)
        }
    }
    /*
    // Setup Views Functions
    */
    func setupOnboardingView() {
        onBoardingView.delegate = self
        onBoardingView.layer.cornerRadius = 13
        onBoardingView.layer.masksToBounds = true
    }
    
    func setupDimOverlayView() {
        dimOverlayView.alpha = 0.6
    }
    
    func setupPanduanLabView() {
        panduanLabView.delegate = self
        panduanLabView.layer.cornerRadius = 13
        panduanLabView.layer.masksToBounds = true
    }
    
    func setupTimelineView() {
        timelineView.delegate = self
    }
    /*
    // Pop-up Related Functions
    */
    func closeOnBoardingView() {
        onBoardingView.isHidden = true
        dimOverlayView.isHidden = true
    }
    
    func showOnBoardingView() {
        onBoardingView.isHidden = false
        dimOverlayView.isHidden = false
    }
    
    func showPanduanView(){
        panduanLabView.isHidden = false
        dimOverlayView.isHidden = false
    }
}
