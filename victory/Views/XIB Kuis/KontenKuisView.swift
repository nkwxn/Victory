//
//  KontenKuisViewController.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class KontenKuisView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizQuestionLabel: UILabel!
    @IBOutlet weak var quizChecklistImage: UIImageView!
    @IBOutlet weak var optionAButton: UIButton!
    @IBOutlet weak var optionBButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    @IBOutlet weak var optionDButton: UIButton!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var jawabanTepatLbl: UILabel!
    @IBOutlet weak var correctAnswerBg: RoundCornersUIView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var pembahasanLbl: UILabel!
    @IBOutlet weak var explanationBg: RoundCornersUIView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func onPreviousButtonPressed(_ sender: UIButton) {
        quizBrain.setQuestionNumber(by: -1)
        setupToPembahasanUI()
    }
    @IBAction func onNextButtonPressed(_ sender: UIButton) {
        switch quizBrain.questionNumber {
        case 5:
            delegate?.showSkorView(quizBrain: quizBrain)
        default:
            quizBrain.setQuestionNumber(by: 1)
            ((quizBrain.questionNumber) <= (quizBrain.getTotalAnsweredQuestion()) ?
                setupToPembahasanUI() : setupToDefaultUI())
        }
    }
    @IBAction func onOptionButtonsPress (_ sender: UIButton) {
        let selectedAnswer = sender.currentTitle!.prefix(1)
        let selectedAnswerKey = QuizOption(rawValue: String(selectedAnswer))
        quizBrain.answerList.append(selectedAnswerKey!)
        quizBrain.totalCorrect += (quizBrain.checkAnswer(selectedAnswer: selectedAnswerKey!) ? 1 : 0)
        setupToPembahasanUI()
    }
    /*
    // Variables
    */
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
    var quizBrain = QuizBrain() // Should recieve data from PraktikumBerpanduanViewController
    var optionButtonList: [UIButton] = []
    /*
    // Init Functions
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("KontenKuisView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // initial Default View Config
        optionButtonList = [optionAButton, optionBButton, optionCButton, optionDButton]
        setupToDefaultUI()
    }
    /*
    // UIView Setup Functions
    */
    private func disableOptionButtons() {
        for button in optionButtonList {
            button.isEnabled = false
        }
    }
    private func enableOptionButtons() {
        for button in optionButtonList {
            button.isEnabled = true
        }
    }
    private func setupQuizComponentsText(isPembahasan: Bool) {
        quizNumberLabel.text = "Nomor \(String(describing: quizBrain.questionNumber))"
        quizQuestionLabel.text = quizBrain.getQuestionText()
        if isPembahasan {
            correctAnswerLabel.text = quizBrain.getCorrectAnswer()
            explanationLabel.text = quizBrain.getExplanation()
        }
    }
    private func showHideExplanationComponent(hidden: Bool) {
        quizChecklistImage.isHidden = hidden
        jawabanTepatLbl.isHidden = hidden
        correctAnswerBg.isHidden = hidden
        correctAnswerLabel.isHidden = hidden
        pembahasanLbl.isHidden = hidden
        explanationBg.isHidden = hidden
        explanationLabel.isHidden = hidden
    }
    private func setupOptionBtnsText() {
        for (index, button) in optionButtonList.enumerated() {
            button.setTitle(quizBrain.getOptions()[index], for: .normal)
        }
    }
    private func resetOptionBtnsColor() {
        for button in optionButtonList {
            button.backgroundColor = UIColor(named: "vc_blue_active")
            button.layer.cornerRadius = 8
        }
    }
    private func setupChecklistImgProperties(with imageName: String, color: UIColor) {
        quizChecklistImage.image = UIImage(systemName: imageName)
        quizChecklistImage.tintColor = color
    }
    private func enableNextBtn() {
        nextButton.isEnabled = true
        nextButton.tintColor = UIColor(named: "vc_blue_active")
        nextLabel.textColor = UIColor(named: "vc_blue_active")
    }
    private func disableNextBtn() {
        nextButton.isEnabled = false
        nextButton.tintColor = UIColor.systemGray
        nextLabel.textColor = UIColor.systemGray
    }
    private func showPrevBtn() {
        previousButton.isHidden = false
        previousLabel.isHidden = false
    }
    private func hidePrevBtn() {
        previousLabel.isHidden = true
        previousButton.isHidden = true
    }
    private func setupToolBarUI(isPembahasan: Bool) {
        let currentNumber = quizBrain.questionNumber
        let totalQuiz = quizBrain.getTotalQuestion()
        currentPageLabel.text = "\(String(describing: currentNumber)) / \(String(describing: totalQuiz))"
        if currentNumber == totalQuiz {
            nextButton.setImage(UIImage(systemName: "flag.circle.fill"), for: .normal)
            nextLabel.text = "Selesai"
        } else {
            nextButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            nextLabel.text = "Selanjutnya"
        }
        (isPembahasan ? enableNextBtn() : disableNextBtn())
        (currentNumber == 1 ? hidePrevBtn() : showPrevBtn())
    }
    /*
    // UIView Setup Main Functions: Pembahasan Kuis UI
    */
    private func setupToPembahasanUI() {
        let selectedAnswer = quizBrain.getAnswer()
        let correctAnswer = quizBrain.getCorrectAnswerKey()
        disableOptionButtons()
        resetOptionBtnsColor()
        showHideExplanationComponent(hidden: false)
        setupQuizComponentsText(isPembahasan: true)
        setupOptionBtnsText()
        setupToolBarUI(isPembahasan: true)
        // Get index of selected and correct answer
        let selectedAnswerIndex = selectedAnswer.getIndex()
        let correctAnswerIndex = correctAnswer.getIndex()
        // Change option buttons' colors according to the answer
        if quizBrain.checkAnswer(selectedAnswer: selectedAnswer) {
            setupChecklistImgProperties(with: "checkmark.circle", color: .systemGreen)
            optionButtonList[selectedAnswerIndex].backgroundColor = .systemGreen
        } else {
            setupChecklistImgProperties(with: "xmark.circle", color: .systemRed)
            optionButtonList[selectedAnswerIndex].backgroundColor = .systemRed
            optionButtonList[correctAnswerIndex].backgroundColor = .systemGreen
        }
    }
    /*
    // UIView Setup Main Functions: Default Kuis UI
    */
    private func setupToDefaultUI() {
        enableOptionButtons()
        resetOptionBtnsColor()
        showHideExplanationComponent(hidden: true)
        setupQuizComponentsText(isPembahasan: false)
        setupOptionBtnsText()
        setupToolBarUI(isPembahasan: false)
    }
    /*
    // UIView Setup Main Functions: Last Visited Number UI
    */
    func setupToLastVisitedNumberUI() {
        ((quizBrain.questionNumber) <= (quizBrain.getTotalAnsweredQuestion()) ?
            setupToPembahasanUI() : setupToDefaultUI())
    }
}
