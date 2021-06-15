//
//  PraktikumBerpanduanViewController.swift
//  victory
//
//  Created by Wuri Dita on 14/06/21.
//

import UIKit

protocol PraktikumBerpanduanViewControllerDelegate: class {
    // Protocol for Timeline View
    func moveToPanduanView()
    func closePanduanView()
    func changeStep(to step: Step)
    // Protocol for Kuis View
    func startKuisView()
    func showSkorView(quizBrain: QuizBrain)
    func closeSkorView()
    // Protocol for Skor View
    func exitPraktikum()
    // Protocol for Materi View
    func showLabView()
    // Protocol for Lab View
    // To - Do Add protocol functions for Lab View
}

class PraktikumBerpanduanViewController: UIViewController, PraktikumBerpanduanViewControllerDelegate {

    @IBOutlet weak var timelineView: TimelineView!
    @IBOutlet weak var onBoardingLabView: OnBoardingLabView!
    @IBOutlet weak var panduanLabView: PanduanLabView!
    @IBOutlet weak var dimOverlayView: DimOverlayView!
    @IBOutlet weak var onBoardingKuisView: OnBoardingKuisView!
    @IBOutlet weak var materiView: MateriView!
    @IBOutlet weak var quizView: KontenKuisView!
    @IBOutlet weak var scoreView: SkorView!
    @IBOutlet weak var finishLabBtn: UIButton!
    // To - Do init @IBOutlets for Lab View
    @IBAction func onBackBtnPressed(_ sender: Any) {
        exitPraktikum()
    }
    @IBAction func onFinishLabBtnPressed(_ sender: UIButton) {
        // Simulation when all step Lab done
        stepDoneList!.append(.labOne)
        stepDoneList!.append(.labTwo)
        stepDoneList!.append(.labThree)
        stepUnlockList!.append(.kuis)
        changeStep(to: .kuis)
        showOnBoardingKuisView()
    }
    var viewList: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Should pass data from MediaViewController via function prepSetup()
        // But these are dummy variable inits, will be deleted soon
        quizBrain = QuizBrain()
        praktikum = Praktikum(nama: "Gerak Prabola", gambar: UIImage(systemName: "sun.max.fill")!,
                              kelas: .k10, mataPelajaran: .fisika, pertanyaanQuiz: quizBrain!)
        currentStep = praktikum?.currentStep
        stepUnlockList = praktikum?.stepUnlockList
        stepDoneList = praktikum?.stepDoneList
        //
        //
        viewList = [timelineView, materiView, quizView, onBoardingLabView, panduanLabView, dimOverlayView,
                    onBoardingKuisView, scoreView] // To - Do add labView
        timelineView.delegate = self
        panduanLabView.delegate = self
        onBoardingLabView.delegate = self
        onBoardingKuisView.delegate = self
        quizView.delegate = self
        scoreView.delegate = self
        materiView.delegate = self
        scoreView.delegate = self
        setupInitialView()
    }
    /*
    // Variables
    */
    // Save data passed from MediaViewController
    var quizBrain: QuizBrain?
    var currentStep: Step?
    var stepDoneList: [Step]?
    var stepUnlockList: [Step]?
    var praktikum: Praktikum? {
        didSet {
            prepSetup()
        }
    }
    /*
    // Delegate Functions
    */
    func moveToPanduanView() {
        closeOnBoardingView()
        showPanduanView()
    }
    func closePanduanView() {
        finishLabBtn.isHidden = false
        panduanLabView.isHidden = true
        dimOverlayView.isHidden = true
    }
    func changeStep(to step: Step) {
        currentStep = step
        for unlockStep in stepUnlockList! {
            timelineView.setupTimelineComponentStage(step: unlockStep, isActive: false, isLocked: false)
        }
        for doneStep in stepDoneList! {
            timelineView.setupBtnImageToDone(for: doneStep, isActive: false)
        }
        timelineView.setupTimelineComponentStage(step: currentStep!, isActive: true, isLocked: false)
        if stepDoneList!.contains(currentStep!) {
            timelineView.setupBtnImageToDone(for: currentStep!, isActive: true)
        }
        changeView(for: step)
    }
    func changeView(for view: Step) {
        // To - Do change view (show - hidden) based on selected timeline's step
        for view in viewList[1...2] {
            view.isHidden = true
        }
        switch view {
        case .materi:
            materiView.isHidden = false
        case .labOne:
            print("To Lab 1 View")
        case .labTwo:
            print("To Lab 2 View")
        case .labThree:
            print("To Lab 3 View")
        case .kuis:
            quizView.isHidden = false
            quizView.setupToLastVisitedNumberUI()
        }
    }
    func startKuisView() {
        onBoardingKuisView.isHidden = true
        quizView.quizBrain = self.quizBrain!
        quizView.isHidden = false
    }
    func showSkorView(quizBrain: QuizBrain) {
        stepDoneList!.append(.kuis)
        changeStep(to: .kuis)
        dimOverlayView.isHidden = false
        scoreView.isHidden = false
        scoreView.setupResultView(quizBrain: quizBrain)
    }
    func closeSkorView() {
        dimOverlayView.isHidden = true
        scoreView.isHidden = true
    }
    func showLabView() {
        stepDoneList!.append(.materi)
        stepUnlockList!.append(.labOne)
        stepUnlockList!.append(.labTwo)
        stepUnlockList!.append(.labThree)
        materiView.isHidden = true
        changeStep(to: .labOne)
        showOnBoardingLabView()
    }
    func exitPraktikum() {
        // To - Do exit to Media StoryBoard
    }
    /*
    // Setup View Functions
    */
    func prepSetup() {
//        quizBrain = praktikum?.quizBrain
//        currentStep = praktikum?.currentStep
//        stepUnlockList = praktikum?.stepUnlockList
//        stepDoneList = praktikum?.stepDoneList
    }
    func setupInitialView() {
        setupPanduanLabView()
        setupOnboardingLabView()
        setupDimOverlayView()
        setupScoreView()
        finishLabBtn.isHidden = true
        // Show - Hide XIB Component on init
        // Only show XIB Materi & Timeline  View
        for view in viewList[2...] {
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
        // To - Do configure panduan contents, different on Lab1,2,3
        panduanLabView.isHidden = false
        dimOverlayView.isHidden = false
    }
    func showOnBoardingKuisView() {
        onBoardingKuisView.isHidden = false
    }
}
