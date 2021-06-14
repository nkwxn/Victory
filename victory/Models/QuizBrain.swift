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
    var answerList: [QuizOption] = []
    let quizList = [
        Quiz(questionNumber: 1, question: "Dari praktikum yang kamu lakukan, apa pengaruh massa terhadap ketinggian proyektil?", options: ["A. Semakin besar massa, maka tinggi maksimum proyektil juga akan semakin besar, dan sebaliknya", "B. Semakin besar massa, maka tinggi maksimum proyektil juga akan semakin kecil, dan sebaliknya", "C. Semakin kecil massa, maka tinggi maksimum proyektil juga akan semakin besar, dan sebaliknya", "D. Massa tidak berpengaruh pada ketinggian maksimum proyektil"], correctAnswerKey: .optionD, explaination: "Sesuai dengan persamaan: y = v0 sin Θ - 1/2gt^2 sehingga dapat disimpulkan bahwa massa tidak berpengaruh pada ketinggian proyektil."),
        Quiz(questionNumber: 2, question: "Dari praktikum yang kamu lakukan, apa pengaruh massa terhadap jarak maksimum proyektil?", options: ["A. Semakin besar massa, maka jarak maksimum yang ditempuh proyektil juga akan semakin jauh, dan sebaliknya", "B. Semakin besar massa, maka jarak maksimum yang ditempuh proyektil juga akan semakin dekat, dan sebaliknya", "C. Semakin kecil massa, maka jarak maksimum yang ditempuh proyektil juga akan semakin jauh dan sebaliknya", "D. Massa tidak berpengaruh pada jarak maksimum yang ditempuh proyektil"], correctAnswerKey: .optionD, explaination: "Sesuai dengan persamaan: x = v0 cos Θ t sehingga dapat disimpulkan bahwa massa tidak berpengaruh pada jarak maksimum yang ditempuh proyektil."),
        Quiz(questionNumber: 3, question: "Dari praktikum yang kamu lakukan, jika kecepatan awal benda makin besar maka tinggi maksimum yang ditempuh benda akan …", options: ["A. semakin besar", "B. semakin kecil", "C. sama saja", "D. tidak dapat ditentukan"], correctAnswerKey: .optionA, explaination: "Sesuai dengan persamaan INI PERSAMAANNYA BELOM YA. Kecepatan awal berbanding lurus dengan tinggi maksimum benda, jika kecepatan awal makin besar, maka tinggi maksimum yang dicapai benda juga akan semakin besar, dan sebaliknya jika kecepatan awal semakin kecil, maka tinggi maksimum juga semakin kecil.Sehingga dapat disimpulkan bahwa semakin besar kecepatan awal benda maka tinggi maksimum yang dicapai juga akan semakin besar."),
        Quiz(questionNumber: 4, question: "Dari praktikum yang kamu lakukan, sudut yang mempunyai jarak maksimum yang terjauh adalah…", options: ["A. 30°", "B. 45°", "C. 60°", "D. 90°"], correctAnswerKey: .optionB, explaination: "Berdasarkan percobaan yang telah dilakukan, diketahui bahwa sudut dengan jarak maksimum adalah 45°. Dapat dibuktikan oleh persamaan: INI BELOM PERSAMAANNYA dimana nilai maksimum dari sin 2Θ  sebesar 1 dapat diperoleh dengan  sebesar  45°."),
        Quiz(questionNumber: 5, question: "Dari praktikum yang kamu lakukan, sudut yang mempunyai tinggi maksimum tertinggi adalah…", options: ["A. 30°", "B. 45°", "C. 60°", "D. 90°"], correctAnswerKey: .optionD, explaination: "Berdasarkan percobaan yang telah dilakukan, diketahui bahwa sudut dengan ketinggian maksimum adalah 90°. Dapat dibuktikan dengan persamaan: dimana nilai maksimum dari sin kuadrat Θ sebesar 1 dapat diperoleh dengan  sebesar 90°.")
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
    func getTotalCorrect() -> Int {
        var totalCorrect = 0
        for quiz in quizList {
            totalCorrect += (quiz.isCorrect! ? 1 : 0)
        }
        return totalCorrect
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
