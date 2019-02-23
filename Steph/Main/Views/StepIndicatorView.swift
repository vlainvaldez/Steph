//
//  StepIndicatorView.swift
//  Steph
//
//  Created by Hero on 22/02/2019.
//  Copyright © 2019 Hero. All rights reserved.
//

import UIKit
import SnapKit

public final class StepIndicatorView: UIView {
    
    public let stepLabel: UILabel = {
        let view: UILabel = UILabel()
        view.text = "Step 01"
        view.font = UIFont.systemFont(
            ofSize: 18.0,
            weight: UIFont.Weight.regular
        )
        view.textColor = UIColor.lightGray
        return view
    }()
    
    public let stepBarIndicator: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // MARK: Stored Properties
    public var stepBarIndicatorWidth: Constraint!
    public var isValidated: Bool = false
    public var isActive: Bool = false
    
    private var stepBarIndicatorHeight: Constraint!
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.subviews(forAutoLayout: [
            self.stepLabel, self.stepBarIndicator
        ])
        
        self.activateConstraint()
    }
    
    // Instance Methods
    public func activateConstraint() {
        self.stepLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.bottom.equalTo(self.stepBarIndicator.snp.top)
            make.centerX.equalToSuperview()
        }
        
        self.stepBarIndicator.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.bottom.equalToSuperview()
            self.stepBarIndicatorWidth = make.width.equalToSuperview().constraint
            self.stepBarIndicatorHeight = make.height.equalTo(3.0).constraint
            make.centerX.equalToSuperview()
        }
    }
    
    public func activate() {
        self.stepLabel.textColor = UIColor.blue
        self.stepBarIndicator.backgroundColor = UIColor.blue
    }
    
    public func isCurrent(_ isCurrent: Bool ) {
        switch isCurrent {
        case true:
            UIView.animate(withDuration: 0.3) {
                self.stepBarIndicatorHeight.update(offset: 5.0)
            }
        case false:
            UIView.animate(withDuration: 0.3) {
                self.stepBarIndicatorHeight.update(offset: 3.0)
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

