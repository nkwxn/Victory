//
//  TimelineView.swift
//  victory
//
//  Created by Wuri Dita on 09/06/21.
//

import UIKit

class TimelineView: UIView {
    
    @IBOutlet weak var materiBtn: UIButton!
    @IBOutlet weak var labSatuBtn: UIButton!
    @IBOutlet weak var labDuaBtn: UIButton!
    @IBOutlet weak var labTigaBtn: UIButton!
    @IBOutlet weak var kuisBtn: UIButton!
    
    @IBOutlet weak var materiPill: UIView!
    @IBOutlet weak var labSatuPill: UIView!
    @IBOutlet weak var labDuaPill: UIView!
    @IBOutlet weak var labTigaPill: UIView!
    @IBOutlet weak var kuisPill: UIView!
    
    @IBOutlet weak var labBg: UIView!
    @IBOutlet weak var separatorSatu: UIView!
    @IBOutlet weak var separatorDua: UIView!
    @IBOutlet weak var separatorTiga: UIView!
    @IBOutlet weak var separatorEmpat: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TimelineView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth]
    }
    
}
