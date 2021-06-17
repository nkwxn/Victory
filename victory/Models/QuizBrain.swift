// swiftlint:disable line_length
//
//  QuizBrain.swift
//  victory
//
//  Created by Jehnsen Hirena Kane on 07/06/21.
//

import UIKit

class QuizBrain {
    var questionNumber: Int
    var totalCorrect = 0
    var answerList: [QuizOption] = []
    let quizList = [
        Quiz(questionNumber: 1, question: "Dari praktikum yang kamu lakukan, apa pengaruh massa terhadap ketinggian proyektil? Semakin______massa, maka tinggi maksimum proyektil juga akan semakin ______, dan sebaliknya.", options: ["A. besar, besar", "B. besar, kecil", "C. kecil, besar", "D. tidak ada pengaruh"], correctAnswerKey: .optionD, explaination: "Sesuai dengan persamaan mencari nilai y berdasarkan waktu, dapat disimpulkan bahwa massa tidak berpengaruh pada ketinggian proyektil."),
        Quiz(questionNumber: 2, question: "Dari praktikum yang kamu lakukan, apa pengaruh massa terhadap jarak maksimum proyektil? Semakin______massa, maka jarak maksimum yang ditempuh proyektil juga akan semakin______, dan sebaliknya.", options: ["A. besar, jauh", "B. besar, dekat", "C. kecil, jauh", "D. tidak ada pengaruh"], correctAnswerKey: .optionD, explaination: "Sesuai dengan persamaan untuk mencari nilai x berdasarkan waktu, dapat disimpulkan bahwa massa tidak berpengaruh pada jarak maksimum yang ditempuh proyektil."),
        Quiz(questionNumber: 3, question: "Dari praktikum yang kamu lakukan, jika kecepatan awal benda makin besar maka tinggi maksimum yang ditempuh benda akan______.", options: ["A. semakin besar", "B. semakin kecil", "C. sama saja", "D. tidak dapat ditentukan"], correctAnswerKey: .optionA, explaination: "Sesuai dengan persamaan untuk menghitung Y maksimum, kecepatan awal berbanding lurus dengan tinggi maksimum benda, jika kecepatan awal makin besar, maka tinggi maksimum yang dicapai benda juga akan semakin besar, dan sebaliknya jika kecepatan awal semakin kecil, maka tinggi maksimum juga semakin kecil.Sehingga dapat disimpulkan bahwa semakin besar kecepatan awal benda maka tinggi maksimum yang dicapai juga akan semakin besar."),
        Quiz(questionNumber: 4, question: "Dari praktikum yang kamu lakukan, sudut yang mempunyai jarak maksimum yang terjauh adalah______.", options: ["A. 30°", "B. 45°", "C. 60°", "D. 90°"], correctAnswerKey: .optionB, explaination: "Berdasarkan percobaan yang telah dilakukan, diketahui bahwa sudut dengan jarak maksimum adalah 45°. Dapat dibuktikan oleh persamaan untuk menghitung x maksimum, dimana nilai maksimum dari sin 2Θ  sebesar 1 dapat diperoleh dengan  sebesar  45°."),
        Quiz(questionNumber: 5, question: "Dari praktikum yang kamu lakukan, sudut yang mempunyai tinggi maksimum tertinggi adalah______.", options: ["A. 30°", "B. 45°", "C. 60°", "D. 90°"], correctAnswerKey: .optionD, explaination: "Berdasarkan percobaan yang telah dilakukan, diketahui bahwa sudut dengan ketinggian maksimum adalah 90°. Dapat dibuktikan dengan persamaan untuk menghitung y maksimum dimana nilai maksimum dari sin kuadrat Θ sebesar 1 dapat diperoleh dengan  sebesar 90°.")
    ]
    init() {
        questionNumber = 1
    }
    /*
    // Struct Functions
    */
    func getQuiz() -> Quiz {
        return quizList[questionNumber - 1]
    }
    func getTotalQuestion() -> Int {
        return quizList.count
    }
    func getQuestionText() -> String {
        return quizList[questionNumber - 1].question
    }
    func getCorrectAnswerKey() -> QuizOption {
        return quizList[questionNumber - 1].correctAnswerKey
    }
    func getCorrectAnswer() -> String {
        let index = quizList[questionNumber - 1].correctAnswerKey.getIndex()
        return quizList[questionNumber - 1].options[index]
    }
    func getExplanation() -> String {
        return quizList[questionNumber - 1].explaination
    }
    func getOptions() -> [String] {
        return quizList[questionNumber - 1].options
    }
    func getAnswer() -> QuizOption {
        return answerList[questionNumber - 1]
    }
    func getTotalAnsweredQuestion() -> Int {
        return answerList.count
    }
    func setQuestionNumber(by number: Int) {
        questionNumber += number
    }
    func checkAnswer(selectedAnswer: QuizOption) -> Bool {
        let correctAnswer = quizList[questionNumber - 1].correctAnswerKey
        return (correctAnswer == selectedAnswer ? true : false)
    }
}
