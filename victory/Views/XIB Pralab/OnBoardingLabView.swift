//
//  OnBoardingLabView.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import UIKit

class OnBoardingLabView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var actionBtn: UIButton!
    @IBAction func onButtonPressed(_ sender: Any) {
        delegate?.moveToPanduanView()
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
        Bundle.main.loadNibNamed("OnBoardingLabView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupView()
    }
    private func setupView() {
        actionBtn.layer.cornerRadius = 8
    }

}
