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
    
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.subviews(forAutoLayout: [
            self.collectionView, self.nextStepButton
        ])
        
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
    
}
