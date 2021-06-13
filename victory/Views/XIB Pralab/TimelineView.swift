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

        delegate?.changeStep(to: step!)
    }
    /*
    // Variables
    */
    var separatorList: [UIView] = []
    var pillList: [RoundCornersUIView] = []
    var buttonList: [UIButton] = []
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
        Bundle.main.loadNibNamed("TimelineView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        separatorList = [separatorSatu, separatorDua, separatorTiga, separatorEmpat]
        pillList = [materiPill, labSatuPill, labDuaPill, labTigaPill, kuisPill]
        buttonList = [materiBtn, labSatuBtn, labDuaBtn, labTigaBtn, kuisBtn]
        
        setupInitialView()
    }
    /*
    // Setup View Functions
    */
    private func setupInitialView() {
        setupTimelineComponentStage(step: .materi, isActive: true, isLocked: false)
        setupTimelineComponentStage(step: .labOne, isActive: false, isLocked: true)
        setupTimelineComponentStage(step: .labTwo, isActive: false, isLocked: true)
        setupTimelineComponentStage(step: .labThree, isActive: false, isLocked: true)
        setupTimelineComponentStage(step: .kuis, isActive: false, isLocked: true)
    }
    
    func setupTimelineComponentStage(step: Step, isActive: Bool, isLocked: Bool) {
        if isActive {
            print("\(step.rawValue) ACTIVE")
            setupToActiveStage(for: step)
        } else {
            if isLocked {
                print("\(step.rawValue) DEFAULT")
                setupToLockStage(for: step)
            } else { setupToNormalStage(for: step) }
        }
    }
    
    func setupToActiveStage(for step: Step) {
        let index = step.getIndex()
        pillList[index].backgroundColor = UIColor(named: "vc_blue_active")
        pillList[index].layer.cornerRadius = 14
        
        buttonList[index].isEnabled = true
        buttonList[index].setImage(step.getImageActive(), for: .normal)
        buttonList[index].tintColor = UIColor.white
        buttonList[index].setTitleColor(UIColor.white, for: .normal)
        buttonList[index].titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        switch step {
        case .labOne:
            labBg.backgroundColor = UIColor(named: "vc_blue_bg")
            separatorList[index - 1].backgroundColor = UIColor(named: "vc_blue_active")
            separatorList[index].backgroundColor = UIColor(named: "vc_blue_active")
            separatorList[index + 1].backgroundColor = UIColor(named: "vc_blue_active")
        case .kuis:
            separatorList[index - 1].backgroundColor = UIColor(named: "vc_blue_active")
        default:
            return
        }
    }
    
    func setupToNormalStage(for step: Step) {
        let index = step.getIndex()
        switch step {
        case .kuis, .materi:
            pillList[index].backgroundColor =  UIColor(named: "vc_blue_bg")
        default:
            pillList[index].backgroundColor = UIColor.clear
            labBg.backgroundColor = UIColor(named: "vc_blue_bg")
        }
        pillList[index].layer.cornerRadius = 14
        
        buttonList[index].isEnabled = true
        buttonList[index].setImage(step.getImageNormal(), for: .normal)
        buttonList[index].tintColor = UIColor(named: "vc_blue_active")
        buttonList[index].setTitleColor(UIColor(named: "vc_blue_active"), for: .normal)
        buttonList[index].titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    func setupToLockStage(for step: Step) {
        let index = step.getIndex()
        switch step {
        case .kuis:
            pillList[index].backgroundColor = UIColor(named: "vc_blue_bg_lock")
        default:
            pillList[index].backgroundColor = UIColor.clear
            labBg.backgroundColor = UIColor(named: "vc_blue_bg_lock")
        }
        pillList[index].layer.cornerRadius = 14
        buttonList[index].isEnabled = false
        buttonList[index].setImage(step.getImageLock(), for: .normal)
        buttonList[index].tintColor = UIColor(named: "vc_blue_text_lock")
        buttonList[index].setTitleColor(UIColor(named: "vc_blue_text_lock"), for: .normal)
        buttonList[index].titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        separatorList[index - 1].backgroundColor = UIColor(named: "vc_blue_text_lock")
    }
    
    func setupBtnImage(for step: Step, isActive: Bool, isDone: Bool) {
        let index = step.getIndex()
        
        if isActive {
            if isDone {
                buttonList[index].setImage(step.getImageDoneActive(), for: .normal)
            } else {
                buttonList[index].setImage(step.getImageActive(), for: .normal)
            }
        } else {
            if isDone {
                buttonList[index].setImage(step.getImageDoneNormal(), for: .normal)
            } else {
                buttonList[index].setImage(step.getImageNormal(), for: .normal)
            }
        }
    }
    
}
