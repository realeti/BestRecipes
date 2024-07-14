//
//  OnboardingCollectionView.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit

class OnboardingCollectionView: UIPageViewController {
    
    lazy var pageVC: [UIViewController] = {
        return [LeftPageViewController(), MiddlePageViewController(), LastPageViewController()]
    }()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        dataSource = self
        delegate = self
        view.backgroundColor = .systemBackground
        
        if let firstViewController = pageVC.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func goToTheNextPage(animated: Bool = true) {
        guard let currentPage = viewControllers?[0] else {return}
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else {return}
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: nil)
        print("123")
    }
        
}

