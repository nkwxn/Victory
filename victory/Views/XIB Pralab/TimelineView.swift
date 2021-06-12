//
//  TimelineView.swift
//  victory
//
//  Created by Wuri Dita on 09/06/21.
//

import UIKit

class TimelineView: UIView {
    
    weak var delegate: XIBTryoutViewControllerDelegate?
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var materiBtn: UIButton!
    @IBOutlet weak var labSatuBtn: UIButton!
    @IBOutlet weak var labDuaBtn: UIButton!
    @IBOutlet weak var labTigaBtn: UIButton!
    @IBOutlet weak var kuisBtn: UIButton!
    
    @IBOutlet weak var materiPill: RoundCornersUIView!
    @IBOutlet weak var labSatuPill: RoundCornersUIView!
    @IBOutlet weak var labDuaPill: RoundCornersUIView!
    @IBOutlet weak var labTigaPill: RoundCornersUIView!
    @IBOutlet weak var kuisPill: RoundCornersUIView!
    
    @IBOutlet weak var labBg: UIView!
    @IBOutlet weak var separatorSatu: UIView!
    @IBOutlet weak var separatorDua: UIView!
    @IBOutlet weak var separatorTiga: UIView!
    @IBOutlet weak var separatorEmpat: UIView!
    
    @IBAction func onTimelineBtnPressed(_ sender: UIButton) {
        let title = sender.titleLabel!.text!
        let start = title.index(title.startIndex, offsetBy: 1)
        let end = title.index(title.endIndex, offsetBy: -1)
        let substring = title[start...end]
        let step = Step(rawValue: "\(substring)")
        
        changeTimelineColor(step: step!)
        delegate?.changeStep(to: step!)
    }
    
    var separatorList: [UIView] = []
    var pillList: [RoundCornersUIView] = []
    var buttonList: [UIButton] = []
    
    override init(frame: CGRect){
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
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        separatorList = [separatorSatu, separatorDua, separatorTiga, separatorEmpat]
        pillList = [materiPill, labSatuPill, labDuaPill, labTigaPill, kuisPill]
        buttonList = [materiBtn, labSatuBtn, labDuaBtn, labTigaBtn, kuisBtn]
        
        setupInitialView()
        
    }
    
    private func changeTimelineColor(step: Step) {
        setupTimelineComponent(step: step, isActive: true, isLocked: false)
        
        switch step {
        case .materi:
            return
        case .labOne:
            labSatuPill.backgroundColor = UIColor.black
        case .labTwo:
            labDuaPill.backgroundColor = UIColor.black
        case .labThree:
            labTigaPill.backgroundColor = UIColor.black
        case .kuis:
            kuisPill.backgroundColor = UIColor.black
        }
    }
    
    private func setupInitialView() {
        setupTimelineComponent(step: .materi, isActive: true, isLocked: false)
        setupTimelineComponent(step: .labOne, isActive: false, isLocked: true)
        setupTimelineComponent(step: .labTwo, isActive: false, isLocked: true)
        setupTimelineComponent(step: .labThree, isActive: false, isLocked: true)
        setupTimelineComponent(step: .kuis, isActive: false, isLocked: true)
    }
    
    private func setupTimelineComponent(step: Step, isActive: Bool, isLocked: Bool) {
        let index = step.getIndex()
        if isActive == true {
            pillList[index].backgroundColor = UIColor.black
            buttonList[index].titleLabel?.textColor = UIColor.white
            buttonList[index].titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            
            switch step {
            case .materi:
                return
            default:
                separatorList[index - 1].backgroundColor = UIColor.black
            }
            
        } else { // isActive false
            if isLocked == false {
                
            } else { // isLocked true
                
            }
        }
    }
    
}
