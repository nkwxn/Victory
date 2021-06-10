//
//  VariabelCell.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class VariabelCell: UITableViewCell {
    @IBOutlet weak var lblVarName: UILabel!
    @IBOutlet weak var imgVariable: UIImageView!
    @IBOutlet weak var lblVarAmount: UILabel!
    @IBOutlet weak var varSlider: UISlider!
    
    var delegate: VariableSliderDelegate?
    
    var variableSetting: SliderVariable? {
        didSet {
            // Label and Images
            lblVarName.text = variableSetting?.rawValue
            imgVariable.image = variableSetting?.getImage()
            lblVarAmount.text = "\(String(describing: variableSetting?.getDefaultValue())) \(variableSetting?.getUnit() ?? "")"
            
            // Slider values
            varSlider.minimumValue = (variableSetting?.getMinSlider())!
            varSlider.maximumValue = (variableSetting?.getMaxSlider())!
            varSlider.value = (variableSetting?.getDefaultValue())!
        }
    }
    
    // Kasih variabel dan delegate untuk initialize yang lainnya
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        lblVarAmount.text = "\(String(describing: sender.value)) \(variableSetting?.getUnit() ?? "")"
        delegate?.sendSliderValue(from: sender.value)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol VariableSliderDelegate {
    func sendSliderValue(from sliderValue: Float)
}
