//
//  OnBoardingKuisView.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class OnBoardingKuisView: UIView {
    @IBOutlet var contentView: OnBoardingKuisView!
    @IBOutlet weak var mulaiBtn: UIButton!
    @IBAction func onMulaiBtnPressed(_ sender: Any) {
        delegate?.startKuisView()
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
        Bundle.main.loadNibNamed("OnBoardingKuisView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // initial Default View Config
        setupView()
    }
    func setupView() {
        mulaiBtn.layer.cornerRadius = 8
    }
}
