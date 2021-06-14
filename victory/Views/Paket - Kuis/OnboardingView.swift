//
//  OnboardingView.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class OnboardingView: UIView {
    
    weak var delegate: KuisViewControllerDelegate?

    @IBOutlet var contentView: OnboardingView!
    @IBOutlet weak var mulaiBtn: UIButton!
    @IBAction func onMulaiBtnPressed(_ sender: Any) {
        delegate?.mulaiKuisView()
    }
    
    /*
    // Init Functions
    */
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    private func commonInit() {
        Bundle.main.loadNibNamed("OnboardingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // initial Default View Config
        setupView()
        
    }
    
    func setupView(){
        mulaiBtn.layer.cornerRadius = 8
    }
}
