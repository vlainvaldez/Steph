//
//  MainView.swift
//  Steph
//
//  Created by Novare Account on 22/02/2019.
//  Copyright © 2019 Novare Account. All rights reserved.
//

import UIKit
import SnapKit

public final class MainView: UIView {
    
    // MARK: Subviews
    public let backButton: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle(
            "Back",
            for: UIControl.State.normal
        )
        
        view.setTitleColor(
            UIColor.black,
            for: UIControl.State.normal
        )
        
        return view
    }()
    
    public let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 0.0
        let view: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.lightGray
        view.isPagingEnabled = true
        return view
    }()
    
    public let nextStepButton: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle("Next", for: UIControl.State.normal)
        view.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    public let stepsIndicatorStackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.axis = .horizontal
        view.distribution = UIStackView.Distribution.equalSpacing
        view.alignment = UIStackView.Alignment.center
        view.spacing = 5.0
        return view
    }()
    
    public let step1Indicator: StepIndicatorView = {
        let view: StepIndicatorView = StepIndicatorView()
        view.stepLabel.text = "Step 01"
        return view
    }()
    
    public let step2Indicator: StepIndicatorView = {
        let view: StepIndicatorView = StepIndicatorView()
        view.stepLabel.text = "Step 02"
        return view
    }()
    
    public let step3Indicator: StepIndicatorView = {
        let view: StepIndicatorView = StepIndicatorView()
        view.stepLabel.text = "Step 03"
        return view
    }()
    
    public let step4Indicator: StepIndicatorView = {
        let view: StepIndicatorView = StepIndicatorView()
        view.stepLabel.text = "Step 04"
        return view
    }()
    
    public lazy var stepIndicatorsView: [StepIndicatorView] = [
        self.step1Indicator, self.step2Indicator,
        self.step3Indicator, self.step4Indicator
    ]
    
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.subviews(forAutoLayout: [
            self.stepsIndicatorStackView,
            self.collectionView, self.nextStepButton
            ])
        
        self.stepsIndicatorStackView.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview().offset(50.0)
            make.leading.equalToSuperview().offset(50.0)
            make.trailing.equalToSuperview().inset(50.0)
            make.height.equalTo(50.0)
            make.centerX.equalToSuperview()
        }
        
        self.collectionView.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.width.equalTo(300.0)
            make.height.equalTo(600.0)
            make.centerX.centerY.equalToSuperview()
        }
        
        self.nextStepButton.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.width.equalTo(300.0)
            make.height.equalTo(60.0)
            make.bottom.equalToSuperview().inset(30.0)
            make.centerX.equalToSuperview()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.populateStackView(stepsIndicator: self.stepIndicatorsView)
        
        if let firstStepIndicator = self.stepIndicatorsView.first {
            firstStepIndicator.activate()
            firstStepIndicator.isCurrent(true)
        }
    }
}

extension MainView {
    
    private func populateStackView(stepsIndicator: [StepIndicatorView]) {
        
        let indicatorWidth: CGFloat  = self.stepsIndicatorStackView.frame.width / 4
        
        stepsIndicator.forEach { (stepIndicatorView: StepIndicatorView) in
            
            self.stepsIndicatorStackView.addArrangedSubview(stepIndicatorView)
            
            stepIndicatorView.activateConstraint()
            stepIndicatorView.stepBarIndicatorWidth.update(offset: indicatorWidth)
        }
    }
}
