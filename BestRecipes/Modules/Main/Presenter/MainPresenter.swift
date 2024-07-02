//
//  MainPresenter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import Foundation

//MARK: - Presenter Protocol

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol)
    
    func performActionForHeader(at index: Int)
}


final class MainPresenter: MainPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    
    var sections = BRMockData.shared.pageData
    
    
    //MARK: - Lifecycle
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}


//MARK: - Internal Methods

extension MainPresenter {
    func performActionForHeader(at index: Int) {
        switch index {
        case 0:
            router?.showTrending()
            print(sections[index].title)
        case 3:
            print(sections[index].title)
        case 4:
            print(sections[index].title)
        default:
            break
        }
    }
}
