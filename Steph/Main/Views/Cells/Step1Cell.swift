//
//  Step1Cell.swift
//  Steph
//
//  Created by Hero on 22/02/2019.
//  Copyright © 2019 Hero. All rights reserved.
//

import UIKit
import SnapKit

public final class Step1Cell: UICollectionViewCell {
    
    // MARK: Subviews
    public let pickerTextField: UITextField = {
        let view: UITextField = UITextField()
        view.borderStyle = UITextField.BorderStyle.line
        return view
    }()
    
    public let carsPickerView: UIPickerView = {
        let view: UIPickerView = UIPickerView()
        return view
    }()
    
    // Stored Properties
    private var choices = ["Toyota","Honda","Chevy","Audi","BMW"]
    private var selectedCar: String = String()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
        
        self.subview(forAutoLayout: self.pickerTextField)
        
        self.pickerTextField.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100.0)
            make.height.equalTo(60.0)
        }
        
        self.pickerTextField.delegate = self
   
        self.pickerTextField.inputView = self.carsPickerView
        self.pickerTextField.inputAccessoryView = self.toolBarBuilder()
        
        self.carsPickerView.dataSource = self
        self.carsPickerView.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public API
extension Step1Cell {
    public static var identifier: String = "Step1Cell"
}

// MARK: - UIPickerViewDataSource Methods
extension Step1Cell: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.choices.count
    }
    
}

// MARK: - UIPickerViewDelegate Methods
extension Step1Cell: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.choices[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCar = self.choices[row]
    }
    
}

// MARK: - UITextFieldDelegate Methods
extension Step1Cell: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}

// MARK: - Target Action Methods
extension Step1Cell {
    
    @objc func donePicker() {
        self.pickerTextField.text = self.selectedCar
        
        self.endEditing(true)
    }
    
}

// MARK: - Helper Methods
extension Step1Cell {
    public func toolBarBuilder() -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(Step1Cell.donePicker)
        )
        
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(Step1Cell.donePicker)
        )
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
