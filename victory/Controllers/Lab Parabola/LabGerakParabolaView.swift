//
//  LabGerakParabolaView.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit
import SpriteKit

class LabGerakParabolaView: UIView {
    @IBOutlet weak var variableTableView: UITableView!
    @IBOutlet weak var skView: SKView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(frame: CGRect, mode: String) {
        super.init(frame: frame)
        print(mode)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let bundle = Bundle.init(for: LabGerakParabolaView.self)
        if let viewFromXIB = bundle.loadNibNamed("LabGerakParabola", owner: self, options: nil), let parabolaView = viewFromXIB.first as? UIView {
            // Initializing the views
            // Adding Subviews
            addSubview(parabolaView)
            parabolaView.frame = self.bounds
            parabolaView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        initTableView()
    }
    
    func initTableView() {
        // Delegate and DataSource
        variableTableView.dataSource = self
        variableTableView.delegate = self
        
        // Register Custom Cells
        variableTableView.register(UINib(nibName: "LabVariableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "VarHeader")
        variableTableView.register(UINib(nibName: "VariabelCell", bundle: nil), forCellReuseIdentifier: "VariableSliderCell")
    }
}
