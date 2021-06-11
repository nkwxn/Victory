//
//  Constants.swift
//  victory
//
//  Created by Daniella Stefani on 10/06/21.
//

import Foundation

class Constants {
    static let arrayOfPraktikum = [
        Praktikum (nama: "Gerak Parabola", gambar: #imageLiteral(resourceName: "gravity"), kelas: .k10, mataPelajaran: .fisika, subtitleMateri: "Materi: Gerak", pertanyaanQuiz: [
            Question(q: "apakah saya cantik?", a: ["ya", "sangat", "betul", "tepat"], correctAnswer: "ya", solusi: "saya memang cantik")
        ]),
        Praktikum (nama: "Gerak Melingkar", gambar: #imageLiteral(resourceName: "gravity"), kelas: .k10, mataPelajaran: .fisika, subtitleMateri: "Materi: Gerak", pertanyaanQuiz: [
            Question(q: "apakah saya cantik?", a: ["ya", "sangat", "betul", "tepat"], correctAnswer: "ya", solusi: "saya memang cantik")
        ]),
        Praktikum (nama: "Stoikiometri", gambar: #imageLiteral(resourceName: "angle"), kelas: .k10, mataPelajaran: .kimia, subtitleMateri: "Materi: Kimia Hitungan", pertanyaanQuiz: [
            Question(q: "apakah saya cantik?", a: ["ya", "sangat", "betul", "tepat"], correctAnswer: "ya", solusi: "saya memang cantik")
        ])
    ]
}
