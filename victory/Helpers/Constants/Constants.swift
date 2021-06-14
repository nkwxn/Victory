//
//  Constants.swift
//  victory
//
//  Created by Daniella Stefani on 10/06/21.
//

import Foundation

class Constants {
    static let arrayOfMediaPraktikum = [
        MediaPraktikum (namaMedia: "Praktikum", gambarMedia: #imageLiteral(resourceName: "angle")),
        MediaPraktikum (namaMedia: "Permainan", gambarMedia: #imageLiteral(resourceName: "gravity_gray")),
        MediaPraktikum (namaMedia: "Augmented Reality", gambarMedia: #imageLiteral(resourceName: "gravity"))
    ]
    
    static let arrayOfPraktikum = [
        Praktikum (nama: "Gerak Parabola", gambar: #imageLiteral(resourceName: "gravity"), kelas: .k10, mataPelajaran: .fisika, subtitleMateri: "Materi: Gerak", pertanyaanQuiz: [
            Question(q: "apakah saya cantik?", a: ["ya", "sangat", "betul", "tepat"], correctAnswer: "ya", solusi: "saya memang cantik")
        ])
    ]
}
