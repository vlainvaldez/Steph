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
        
        self.currentSteps.append(1)
    }
    
    // MARK: Instance Methods
    
    // MARK: Stored Properties
    private var stepCounter: Int = 1
    private var currentSteps: [Int] = [Int]()
    private var totalSteps: [Int] = [1,2,3,4]
    
    // MARK: Computed Properties
}

extension MainVC {
    unowned var rootView: MainView { return self.view as! MainView }
    unowned var collectionView: UICollectionView { return self.rootView.collectionView }
}

extension MainVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentSteps.count
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
    
}

// MARK: Target Action Method
extension MainVC {
    
    @objc func nextButtonTapped() {
        
        if self.currentSteps.count < CellStep.allCases.count {
            
            self.currentSteps.append(1)
            
            self.collectionView.reloadData()
            
            let indexPath: IndexPath = IndexPath(item: self.stepCounter, section: 0)
            
            self.collectionView.scrollToItem(
                at: indexPath,
                at: UICollectionView.ScrollPosition.right,
                animated: true
            )
            
            self.stepCounter += 1
            
        }        
    }
}

