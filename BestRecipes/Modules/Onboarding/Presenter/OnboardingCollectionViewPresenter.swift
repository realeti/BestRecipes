//
//  OnboardingCollectionView.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit

protocol OnboardingCollectionDelegate: AnyObject{
    func setNewsControllers()
}

class OnBoardingCollectionViewPresenter: OnboardingCollectionDelegate {
    
    var pageViewController: OnboardingCollectionView?
    
    init(pageViewController: OnboardingCollectionView?) {
        self.pageViewController = pageViewController
    }
    
    func setNewsControllers() {
        print("11111")
    }
    
}
