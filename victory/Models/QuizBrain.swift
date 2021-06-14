//
//  QuizBrain.swift
//  victory
//
//  Created by Jehnsen Hirena Kane on 07/06/21.
//

import UIKit

struct QuizBrain {
    var questionNumber = 0
    var score = 0
    let quiz = [
        Question(question: "Which is the largest organ in the human body?",
                 answer: ["Heart", "Skin", "Large Intestine"],
                 correctAnswer: "Skin",
                 solusi: "eheeheheh")
    ]
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    // Need a way of fetching the answer choices
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    mutating func getScore() -> Int {
        return score
    }
    mutating func nextQuestion() {
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    mutating func checkAnswer(userAnswer: String) -> Bool {
        // Need to change answer to rightAnswer here
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
}
