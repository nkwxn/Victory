//
//  PraktikumBerpanduanViewController.swift
//  victory
//
//  Created by Wuri Dita on 14/06/21.
//

import UIKit

protocol PraktikumBerpanduanViewControllerDelegate: class {
    /*
    // Protocol for Timeline View
    */
    func moveToPanduanView()
    func closePanduanView()
    func changeStep(to step: Step)
    /*
    // Protocol for Kuis View
    */
    func startKuisView()
    func showSkorView(totalCorrect: Int, totalQuiz: Int)
    func closeSkorView()
    /*
    // Protocol for Lab View
    */
    // To - Do Add protocol functions for Lab View
}

class PraktikumBerpanduanViewController: UIViewController, PraktikumBerpanduanViewControllerDelegate {

    @IBOutlet weak var timelineView: TimelineView!
    @IBOutlet weak var onBoardingLabView: OnBoardingLabView!
    @IBOutlet weak var panduanLabView: PanduanLabView!
    @IBOutlet weak var dimOverlayView: DimOverlayView!
    @IBOutlet weak var onBoardingKuisView: OnBoardingKuisView!
    @IBOutlet weak var quizView: KontenKuisView!
    @IBOutlet weak var scoreView: SkorView!
    @IBOutlet weak var finishMateriBtn: UIButton!
    @IBOutlet weak var finishLabBtn: UIButton!
    // To - Do init @IBOutlets for Lab View
    @IBAction func onBackBtnPressed(_ sender: Any) {
        // To - Do exit Praktikum (back to Mathod Page options)
        print("keluar Praktikum")
    }
    @IBAction func onFinishLabBtnPressed(_ sender: UIButton) {
        // Simulation when all step Lab done
        stepUnlockList.append(.kuis)
        stepDoneList.append(.labOne)
        stepDoneList.append(.labTwo)
        stepDoneList.append(.labThree)
        changeStep(to: .kuis)
        showOnBoardingKuisView()
    }
    @IBAction func onFinishMateriBtnPressed(_ sender: UIButton) {
        // Simulation when step Materi done
        stepUnlockList.append(.labOne)
        stepUnlockList.append(.labTwo)
        stepUnlockList.append(.labThree)
        stepDoneList.append(.materi)
        finishMateriBtn.isHidden = true
        finishLabBtn.isHidden = false
        changeStep(to: .labOne)
        showOnBoardingLabView()
    }
    var viewList: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewList = [timelineView, onBoardingLabView, panduanLabView, dimOverlayView,
                    onBoardingKuisView, scoreView, quizView] // , materiView, labView
        timelineView.delegate = self
        panduanLabView.delegate = self
        onBoardingLabView.delegate = self
        onBoardingKuisView.delegate = self
        quizView.delegate = self
        scoreView.delegate = self
        setupView()
    }
    /*
    // Variables
    */
    var currentStep: Step = .materi
    var stepUnlockList: [Step] = [.materi]
    var stepDoneList: [Step] = []
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
        currentStep = step
        for unlockStep in stepUnlockList {
            timelineView.setupTimelineComponentStage(step: unlockStep, isActive: false, isLocked: false)
        }
        for doneStep in stepDoneList {
            timelineView.setupBtnImageToDone(for: doneStep, isActive: false)
        }
        timelineView.setupTimelineComponentStage(step: currentStep, isActive: true, isLocked: false)
        if stepDoneList.contains(currentStep) {
            timelineView.setupBtnImageToDone(for: currentStep, isActive: true)
        }
        changeView(for: step)
    }
    func changeView(for view: Step) {
        // To - Do change view (show - hidden) based on selected timeline's step
    }
    func startKuisView() {
        onBoardingKuisView.isHidden = true
        quizView.isHidden = false
    }
    func showSkorView(totalCorrect: Int, totalQuiz: Int) {
        stepDoneList.append(.kuis)
        changeStep(to: .kuis)
        dimOverlayView.isHidden = false
        scoreView.isHidden = false
        scoreView.setupResultView(for: totalCorrect, totalQuiz: totalQuiz)
    }
    func closeSkorView() {
        dimOverlayView.isHidden = true
        scoreView.isHidden = true
    }
    /*
    // Setup View Functions
    */
    func setupView() {
        setupPanduanLabView()
        setupOnboardingLabView()
        setupDimOverlayView()
        setupScoreView()
        finishLabBtn.isHidden = true
        // Show - Hide XIB Component on init
        // Only show XIB Materi & Timeline  View
        for view in viewList[1...] {
            view.isHidden = true
        }
    }
    func setupOnboardingLabView() {
        onBoardingLabView.layer.cornerRadius = 13
        onBoardingLabView.layer.masksToBounds = true
    }
    func setupDimOverlayView() {
        dimOverlayView.alpha = 0.6
    }
    func setupPanduanLabView() {
        panduanLabView.layer.cornerRadius = 13
        panduanLabView.layer.masksToBounds = true
    }
    func setupScoreView() {
        scoreView.layer.cornerRadius = 13
        scoreView.layer.masksToBounds = true
    }
    /*
    // Pop-up Related Functions
    */
    func closeOnBoardingView() {
        onBoardingLabView.isHidden = true
        dimOverlayView.isHidden = true
    }
    func showOnBoardingLabView() {
        onBoardingLabView.isHidden = false
        dimOverlayView.isHidden = false
    }
    func showPanduanView() {
        panduanLabView.isHidden = false
        dimOverlayView.isHidden = false
    }
    func showOnBoardingKuisView() {
        onBoardingKuisView.isHidden = false
    }
}
