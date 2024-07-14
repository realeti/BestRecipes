//
//  Extension+PageVC.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit


extension OnboardingCollectionView: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageVC.firstIndex(of: viewController) else {return nil}
        let previosIndes = viewControllerIndex - 1
        guard previosIndes >= 0 else {return nil}
        guard pageVC.count > previosIndes else {
            return nil
        }
        return pageVC[previosIndes]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageVC.firstIndex(of: viewController) else {return nil}
        let previosIndes = viewControllerIndex + 1
        guard pageVC.count != previosIndes else {return nil }
        guard pageVC.count > previosIndes else {return nil }
        
        return pageVC[previosIndes]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageVC.count
    }
    
}
