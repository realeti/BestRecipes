//
//  OnboardingPresenter.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit

protocol OnboardingPresenterDelegate: AnyObject{
    func segueNextView()
}

protocol OnboardingPresenterProtocol: AnyObject{
    init(view: OnboardingViewController, router: RouterProtocol)
    func onTapButton()
}

class OnBoardingPresenter: OnboardingPresenterDelegate, OnboardingPresenterProtocol {
    
    
    required init(view: OnboardingViewController, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    

    weak var view: OnboardingViewControllerDelegate?
    var router: RouterProtocol
    
    func onTapButton() {
       router.pushOBInCV()
    }
    
    func segueNextView() {
        
    }
    
} 
