//
//  SkorView.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class SkorView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var benarLbl: UILabel!
    @IBOutlet weak var salahLbl: UILabel!
    @IBOutlet weak var kembaliBtn: UIButton!
    @IBOutlet weak var keluarPraktikumBtn: UIButton!
    @IBAction func onKembaliBtnPressed(_ sender: UIButton) {
        delegate?.closeSkorView()
    }
    @IBAction func onCloseBtnPressed(_ sender: Any) {
        delegate?.closeSkorView()
    }
    @IBAction func onKeluarPraktikumBtnPressed(_ sender: UIButton) {
        delegate?.exitPraktikum()
    }
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
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
        Bundle.main.loadNibNamed("SkorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        kembaliBtn.layer.cornerRadius = 8
        keluarPraktikumBtn.layer.cornerRadius = 8
    }
    func setupResultView(quizBrain: QuizBrain) {
        let totalCorrect = quizBrain.totalCorrect
        let totalQuiz = quizBrain.getTotalQuestion()
        benarLbl.text = "\(String(describing: totalCorrect))/\(String(describing: totalQuiz))"
        salahLbl.text = "\(totalQuiz - totalCorrect)/\(String(describing: totalQuiz))"
        scoreLbl.text = "\(totalCorrect * 20)/\(totalQuiz * 20)"
    }
}
