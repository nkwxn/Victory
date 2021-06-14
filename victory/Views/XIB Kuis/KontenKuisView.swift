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
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func onPreviousButtonPressed(_ sender: UIButton) {
        changeCurrentNumber(by: -1)
        setupToPembahasanUI()
    }
    @IBAction func onNextButtonPressed(_ sender: UIButton) {
        switch currentNumber {
        case 5:
            delegate?.showSkorView()
        default:
            changeCurrentNumber(by: 1)
            (currentNumber <= answerList.count ?
                setupToPembahasanUI() : setupToDefaultUI())
        }
    }
    @IBAction func onOptionButtonsPress (_ sender: UIButton) {
        let quiz = Constants.QuestionList[currentNumber - 1]
        let selectedAnswer = sender.currentTitle!.prefix(1)
        let selectedAnswerKey = QuizOption(rawValue: String(selectedAnswer))
        answerList.append(selectedAnswerKey!)
        let isCorrect = (quiz.checkAnswer(selectedAnswer: selectedAnswerKey!))
        quiz.changeIsCorrect(isCorrect: isCorrect)
        setupToPembahasanUI()
    }
    /*
    // Variables
    */
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
    var currentNumber = 1
    var answerList: [QuizOption] = []
    var totalQuiz = Constants.QuestionList.count
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
    private func changeCurrentNumber(by number: Int) {
        currentNumber += number
    }
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
    private func setupQuizComponentsText(quiz: Question, isPembahasan: Bool) {
        quizNumberLabel.text = quiz.questionNumber
        quizQuestionLabel.text = quiz.question
        if isPembahasan {
            correctAnswerLabel.text = quiz.options[quiz.correctAnswerKey.getIndex()]
            explanationLabel.text = quiz.explaination
        }
    }
    private func showExplanationComponents() {
        quizChecklistImage.isHidden = false
        correctAnswerLabel.isHidden = false
        explanationLabel.isHidden = false
    }
    private func hideExplanationComponents() {
        quizChecklistImage.isHidden = true
        correctAnswerLabel.isHidden = true
        explanationLabel.isHidden = true
    }
    private func setupOptionBtnsText(quiz: Question) {
        for (index, button) in optionButtonList.enumerated() {
            button.setTitle(quiz.options[index], for: .normal)
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
        currentPageLabel.text = "\(currentNumber) / \(totalQuiz)"
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
        let selectedAnswer = answerList[currentNumber - 1]
        let quiz = Constants.QuestionList[currentNumber - 1]
        let correctAnswer = quiz.correctAnswerKey
        disableOptionButtons()
        resetOptionBtnsColor()
        showExplanationComponents()
        setupQuizComponentsText(quiz: quiz, isPembahasan: true)
        setupOptionBtnsText(quiz: quiz)
        setupToolBarUI(isPembahasan: true)
        // Get index of selected and correct answer
        let selectedAnswerIndex = selectedAnswer.getIndex()
        let correctAnswerIndex = correctAnswer.getIndex()
        // Change option buttons' colors according to the answer
        if quiz.isCorrect == true {
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
        let quiz = Constants.QuestionList[currentNumber - 1]
        enableOptionButtons()
        resetOptionBtnsColor()
        hideExplanationComponents()
        setupQuizComponentsText(quiz: quiz, isPembahasan: false)
        setupOptionBtnsText(quiz: quiz)
        setupToolBarUI(isPembahasan: false)
    }
    /*
    // UIView Setup Main Functions: Last Visited Number UI
    */
    func setupToLastVisitedNumberUI() {
        // To - Do to show on which number of kuis is last visited,
            // back to it when kuis is selected again on timeline
        (currentNumber <= answerList.count ?
            setupToPembahasanUI() : setupToDefaultUI())
    }
}
