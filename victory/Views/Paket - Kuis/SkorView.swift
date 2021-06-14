//
//  SkorView.swift
//  victory
//
//  Created by Yuliana Aulele on 10/06/21.
//

import UIKit

class SkorView: UIView {

    weak var delegate: KuisViewControllerDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var benarLbl: UILabel!
    @IBOutlet weak var salahLbl: UILabel!
    @IBOutlet weak var kembaliBtn: UIButton!
    @IBOutlet weak var keluarPraktikumBtn: UIButton!
    
    
    @IBAction func onKembaliBtnPressed(_ sender: UIButton) {
        delegate?.closeSkorView()
    }
    
    @IBAction func onKeluarPraktikumBtnPressed(_ sender: UIButton) {
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
        Bundle.main.loadNibNamed("SkorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setUpView()
    
    }
    func setUpView() {
        kembaliBtn.layer.cornerRadius = 8
        keluarPraktikumBtn.layer.cornerRadius = 8
    }
  

}
