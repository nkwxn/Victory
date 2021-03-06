// swiftlint:disable trailing_whitespace
//
//  VariabelCell.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

class VariableSliderCell: UITableViewCell {
    @IBOutlet weak var lblVarName: UILabel!
    @IBOutlet weak var imgVariable: UIImageView!
    @IBOutlet weak var lblVarAmount: UILabel!
    @IBOutlet weak var varSlider: UISlider!
    
    weak var delegate: VariableSliderDelegate?
    
    var variableSetting: SliderVariable? {
        didSet {
            // Label and Images
            guard let variableName = variableSetting?.rawValue,
                  let acronym = variableSetting?.getAcronym()
            else { return }
            lblVarName.text = "\(variableName) (\(acronym))"
            imgVariable.image = variableSetting?.getImage()
            guard let defaultValue = variableSetting?.getDefaultValue(),
                  let unitOfMeasurement = variableSetting?.getUnit() else { return }
            lblVarAmount.text = "\(defaultValue) \(unitOfMeasurement)"
            
            // Slider values
            varSlider.minimumValue = (variableSetting?.getMinSlider())!
            varSlider.maximumValue = (variableSetting?.getMaxSlider())!
            varSlider.setValue((variableSetting?.getDefaultValue())!, animated: true)
        }
    }
    // Kasih variabel dan delegate untuk initialize yang lainnya
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        lblVarAmount.text = "\(sender.value.rounded()) \(variableSetting?.getUnit() ?? "")"
        delegate?.sendSliderValue(from: sender.value.rounded(), withUnit: variableSetting)
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

protocol VariableSliderDelegate: class {
    func sendSliderValue(from sliderValue: Float, withUnit: SliderVariable?)
}
