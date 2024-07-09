//
//  SearchPresenter.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, router: RouterProtocol)
}

final class SearchPresenter: SearchViewPresenterProtocol {
    weak var view: SearchViewProtocol?
    let router: RouterProtocol
    
    required init(view: SearchViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
