// swiftlint:disable line_length
//
//  Constants.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import Foundation

class Constants {
    static let subjects: [Mapel] = [.fisika, .kimia, .biologi, .matematika]
    static let classes: [Kelas] = [.k10, .k11, .k12]
    static let arrayOfTipePraktikum = [
        TipePraktikum(namaTipe: "Dengan Panduan (LKS)", gambarTipe: #imageLiteral(resourceName: "praktikum_LKS")),
        TipePraktikum(namaTipe: "Eksplorasi Mandiri", gambarTipe: #imageLiteral(resourceName: "praktikum_freestyle"))
    ]
    static let arrayOfMediaPraktikum = [
        MediaPraktikum(namaMedia: "Praktikum", gambarMedia: #imageLiteral(resourceName: " media_praktikum")),
        MediaPraktikum(namaMedia: "Permainan", gambarMedia: #imageLiteral(resourceName: "media_permainan")),
        MediaPraktikum(namaMedia: "Augmented Reality (AR)", gambarMedia: #imageLiteral(resourceName: "media_AR"))
    ]
    static let arrayOfPraktikum = [
        Praktikum(nama: "Gerak Parabola", gambar: #imageLiteral(resourceName: "materi_3"), kelas: .k10, mataPelajaran: .fisika,
                   subtitleMateri: "Gerak Benda", pertanyaanQuiz: QuizBrain(), currentStep: .materi,
                   stepUnlockList: [.materi], stepDoneList: []),
        Praktikum(nama: "Energi Potensial & Kinetik", gambar: #imageLiteral(resourceName: "materi_1"), kelas: .k10, mataPelajaran: .fisika,
                   subtitleMateri: "Energi", pertanyaanQuiz: QuizBrain(), currentStep: .materi,
                   stepUnlockList: [.materi], stepDoneList: []),
        Praktikum(nama: "Hukum I Newton", gambar: #imageLiteral(resourceName: "materi_2"), kelas: .k11, mataPelajaran: .fisika,
                   subtitleMateri: "Hukum Newton", pertanyaanQuiz: QuizBrain(), currentStep: .materi,
                   stepUnlockList: [.materi], stepDoneList: []),
        Praktikum(nama: "Bunyi", gambar: #imageLiteral(resourceName: "materi_4"), kelas: .k12, mataPelajaran: .fisika,
                   subtitleMateri: "Gelombang Bunyi", pertanyaanQuiz: QuizBrain(), currentStep: .materi,
                   stepUnlockList: [.materi], stepDoneList: [])
    ]
    static let panduanLabs = [
        Panduanlab(langkah: ["Tujuan Lab 1: Menentukan pengaruh massa dalam gerak parabola. Langkah-langkahnya adalah sebagai berikut", "Pada Lab 1, variabel sudut lemparan (??) sebesar 30?? dan kecepatan awal (vo) sebesar 100 m/s bernilai konstan", "Pada bagian Variabel, atur massa proyektil sebesar 1 kg kemudian luncurkan proyektil tersebut", "Amati jarak tembaknya (Xmax), isi tabel lembar kerja", "Hitung ketinggian maksimum yang dapat dicapai proyektil (Ymax) dan waktu yang dibutuhkan untuk menempuh ketinggian maksimum (t(Ymax)), isi tabel lembar kerja", "Ulangi langkah 2,3,4 namun menggunakan proyektil dengan massa 10, 50, 100, dan 200 kg", "Jika jawaban pada tabel lembar kerja sudah tepat, maka isian akan berubah warna menjadi hijau"]),
        Panduanlab(langkah: ["Tujuan Lab 2: Menentukan pengaruh sudut lemparan dalam gerak parabola. Langkah-langkahnya adalah sebagai berikut", "Pada Lab 2, variabel kecepatan awal (vo) sebesar 100 m/s dan massa proyektil sebesar 50 kg bernilai konstan", "Pada bagian Variabel, atur sudut lemparan (??) sebesar 0?? kemudian luncurkan proyektil tersebut", "Amati jarak tembaknya (Xmax), isi tabel lembar kerja", "Hitung ketinggian maksimum yang dapat dicapai proyektil (Ymax) dan waktu yang dibutuhkan untuk menempuh ketinggian maksimum (t(Ymax)), isi tabel lembar kerja", "Ulangi langkah 2,3,4 namun menggunakan sudut lemparan 30??, 45??, 60??, dan 90??", "Jika jawaban pada tabel lembar kerja sudah tepat, maka isian akan berubah warna menjadi hijau"]),
        Panduanlab(langkah: ["Tujuan Lab 3: Menentukan pengaruh kecepatan awal dalam gerak parabola. Langkah-langkahnya adalah sebagai berikut", "Pada Lab 3, variabel variabel sudut lemparan (??) sebesar 45?? dan massa proyektil sebesar 50 kg bernilai konstan", "Pada bagian Variabel, atur kecepatan awal (vo) sebesar 10 m/s kemudian luncurkan proyektil tersebut", "Amati jarak tembaknya (Xmax), isi tabel lembar kerja", "Hitung ketinggian maksimum yang dapat dicapai proyektil (Ymax) dan waktu yang dibutuhkan untuk menempuh ketinggian maksimum (t(Ymax)), isi tabel lembar kerja", "Ulangi langkah 2,3,4 namun menggunakan kecepatan awal sebesar 20, 30, 40, dan 50 m/s", "Jika jawaban pada tabel lembar kerja sudah tepat, maka isian akan berubah warna menjadi hijau"])
    ]
}
