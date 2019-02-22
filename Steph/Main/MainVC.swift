//
//  ViewController.swift
//  Steph
//
//  Created by Novare Account on 22/02/2019.
//  Copyright © 2019 Novare Account. All rights reserved.
//

import UIKit

public final class MainVC: UIViewController {
    
    // MARK: Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    public override func loadView() {
        super.loadView()
        
        self.view = MainView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(Step1Cell.self, forCellWithReuseIdentifier: Step1Cell.identifier)
        self.collectionView.register(Step2Cell.self, forCellWithReuseIdentifier: Step2Cell.identifier)
        self.collectionView.register(Step3Cell.self, forCellWithReuseIdentifier: Step3Cell.identifier)
        self.collectionView.register(Step4Cell.self, forCellWithReuseIdentifier: Step4Cell.identifier)
        
        
        self.rootView.nextStepButton.addTarget(
            self,
            action: #selector(MainVC.nextButtonTapped),
            for: UIControl.Event.touchUpInside
        )
        
        self.currentVisibleSteps.append(1)
        
    }
    
    // MARK: Instance Methods
    
    // MARK: Stored Properties
    private var stepCounter: Int = 1
    private var currentVisibleSteps: [Int] = [Int]()
    private var totalSteps: [Int] = [1,2,3,4]
    private var currentPage: Int = 0
    
    // MARK: Computed Properties
}

// MARK: - Views
extension MainVC {
    unowned var rootView: MainView { return self.view as! MainView }
    unowned var collectionView: UICollectionView { return self.rootView.collectionView }
}

// MARK: Target Action Methods
extension MainVC {
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MainVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentVisibleSteps.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cellStep = CellStep(rawValue: indexPath.item) {
            
            switch cellStep {
            case .emailInput:
                guard
                    let cell: Step1Cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: Step1Cell.identifier,
                        for: indexPath
                        ) as? Step1Cell
                    
                    else { return UICollectionViewCell() }
                return cell
                
            case .mobileVerification:
                guard
                    let cell: Step2Cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: Step2Cell.identifier,
                        for: indexPath
                        ) as? Step2Cell
                    
                    else { return UICollectionViewCell() }
                return cell
                
            case .profileCreation:
                guard
                    let cell: Step3Cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: Step3Cell.identifier,
                        for: indexPath
                        ) as? Step3Cell
                    
                    else { return UICollectionViewCell() }
                return cell
            case .agreement:
                guard
                    let cell: Step4Cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: Step4Cell.identifier,
                        for: indexPath
                        ) as? Step4Cell
                    
                    else { return UICollectionViewCell() }
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: self.rootView.collectionView.frame.width,
            height: self.rootView.collectionView.frame.height
        )
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        self.currentPage = Int(offSet + horizontalCenter) / Int(width)
        print(self.currentPage)
        
        self.activateNextStepIndicator(index: self.currentPage)
        
    }
    
    
}

// MARK: Target Action Method
extension MainVC {
    
    @objc func nextButtonTapped() {
        
        if self.currentVisibleSteps.count < self.totalSteps.count {
            
            if self.currentPage + 1 == self.currentVisibleSteps.count {
                self.validateForm(cellStep: self.currentPage + 1)
            }
        }
        
        if self.currentPage + 1 != self.totalSteps.count {
            self.currentPage = self.currentPage + 1
            
            self.activateNextStepIndicator(index: self.currentPage)
            
            let indexPath: IndexPath = IndexPath(item: self.currentPage, section: 0)
            
            self.collectionView.scrollToItem(
                at: indexPath,
                at: UICollectionView.ScrollPosition.right,
                animated: true
            )
        }
    }
}

// MARK: Helper Functions
extension MainVC {
    
    private func validateForm(cellStep: Int) {
        self.currentVisibleSteps.append(1)
        self.collectionView.reloadData()
    }
    
    private func activateNextStepIndicator(index: Int) {
        
        let indicator = self.rootView.stepIndicatorsView[index]
        
        self.rootView.stepIndicatorsView.forEach { (step: StepIndicatorView) in
            step.isCurrent(false)
        }
        
        indicator.activate()
        indicator.isCurrent(true)
        
    }
    
}
