// swiftlint:disable trailing_whitespace
// swiftlint:disable cyclomatic_complexity
//
//  PraktikumBerpanduanViewController.swift
//  victory
//
//  Created by Wuri Dita on 14/06/21.
//

import UIKit

protocol PraktikumBerpanduanViewControllerDelegate: AnyObject {
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
    @IBOutlet var praktikum1View: UIView!
    @IBOutlet var praktikum2View: UIView!
    @IBOutlet var praktikum3View: UIView!
    
    @IBOutlet weak var panduanLabView: PanduanLabView!
    @IBOutlet weak var dimOverlayView: DimOverlayView!
    @IBOutlet weak var onBoardingKuisView: OnBoardingKuisView!
    @IBOutlet weak var materiView: MateriView!
    @IBOutlet weak var quizView: KontenKuisView!
    @IBOutlet weak var scoreView: SkorView!
    @IBOutlet weak var finishLabBtn: UIButton!
    // To - Do init @IBOutlets for Lab View

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
    var isQuizOnboardingDone = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // initializing the LabGerakParabolaView and the delegate methods
        let praktikumFrame = CGRect(x: 0, y: 0, width: praktikum1View.frame.width, height: praktikum1View.frame.height)
        let prak1 = LabGerakParabolaView(frame: praktikumFrame, noLab: 0)
        let prak2 = LabGerakParabolaView(frame: praktikumFrame, noLab: 1)
        let prak3 = LabGerakParabolaView(frame: praktikumFrame, noLab: 2)
        //
        prak1.delegate = self
        prak2.delegate = self
        prak3.delegate = self
        //
        praktikum1View.addSubview(prak1)
        praktikum2View.addSubview(prak2)
        praktikum3View.addSubview(prak3)
        //
        viewList = [timelineView, materiView, quizView, praktikum1View, praktikum2View, praktikum3View,
                    onBoardingLabView, panduanLabView, dimOverlayView, onBoardingKuisView, scoreView]
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
            print(unlockStep)
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
        for view in viewList[1...5] {
            view.isHidden = true
        }
        switch view {
        case .materi:
            materiView.isHidden = false
        case .labOne:
            print("To Lab 1 View")
            praktikum1View.isHidden = false
        case .labTwo:
            praktikum2View.isHidden = false
            print("To Lab 2 View")
        case .labThree:
            print("To Lab 3 View")
            praktikum3View.isHidden = false
        case .kuis:
            quizView.isHidden = false
        }
    }
    func startKuisView() {
        if !isQuizOnboardingDone {
            showOnBoardingKuisView()
            isQuizOnboardingDone = true
            quizView.quizBrain = self.quizBrain!
            quizView.isHidden = true
        } else {
            onBoardingKuisView.isHidden = true
            quizView.quizBrain = self.quizBrain!
            quizView.isHidden = false
        }
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
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // Setup View Functions
    */
    func prepSetup() {
        quizBrain = praktikum?.pertanyaanQuiz
        currentStep = praktikum?.currentStep
        stepUnlockList = praktikum?.stepUnlockList
        stepDoneList = praktikum?.stepDoneList
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
        /*
        let currentWindow: UIWindow? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        
        dimOverlayView.frame = self.view.bounds
        currentWindow?.addSubview(dimOverlayView)
        */
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = praktikum?.nama
    }
}

extension PraktikumBerpanduanViewController: LabGerakParabolaDelegate {
    func presentView(_ view: UIViewController, completion: (() -> Void)?) {
        self.present(view, animated: true, completion: completion)
    }
    
    // Validasi jika seluruhnya benar / salah
    func validateLKS(forLabSection: Int, lksCorrect: Bool) {
        print("LKS is validating")
        print("Lab Section: \(forLabSection)")
        print("All Correct: \(lksCorrect)")
        
        if lksCorrect {
            switch forLabSection {
            case 0:
                stepDoneList?.append(.labOne)
            case 1:
                stepDoneList?.append(.labTwo)
            case 2:
                stepDoneList?.append(.labThree)
            default:
                print("LKS unknown")
            }
        } else {
            switch forLabSection {
            case 0:
                stepDoneList?.removeAll(where: {
                    $0 == .labOne
                })
                timelineView.onTimelineBtnPressed(timelineView.buttonList[1])
            case 1:
                stepDoneList?.removeAll(where: {
                    $0 == .labTwo
                })
                timelineView.onTimelineBtnPressed(timelineView.buttonList[2])
            case 2:
                stepDoneList?.removeAll(where: {
                    $0 == .labThree
                })
                timelineView.onTimelineBtnPressed(timelineView.buttonList[3])
            default:
                print("LKS unknown")
            }
        }
        
        // If All LKS Done unlock Quiz
        guard let labOneDone = stepDoneList?.contains(.labOne),
              let labTwoDone = stepDoneList?.contains(.labTwo),
              let labThreeDone = stepDoneList?.contains(.labThree)
        else { return }
        
        let allLabsDone = labOneDone && labTwoDone && labThreeDone
        
        if allLabsDone {
            stepUnlockList?.append(.kuis)
//            let alert = UIAlertController(title: "Anda telah menyelesaikan seluruh LKS praktikum.",
//                                          message: "Langkah selanjutnya dari lab ini adalah Quiz. Silahkan tekan OK untuk melanjutkan",
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
//                <#code#>
//            }))
//            present(alert, animated: true, completion: { print("Should popup window open") })
//            changeStep(to: .kuis)
        } else {
            stepUnlockList?.removeAll(where: {
                $0 == .kuis
            })
        }
    }
}
