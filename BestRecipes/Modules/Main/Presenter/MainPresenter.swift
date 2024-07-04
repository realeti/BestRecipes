//
//  MainPresenter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import Foundation

//MARK: - Presenter Protocol

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func performActionForHeader(at index: Int)
    func addToFavorites()
    func removeFromFavorites()
}


final class MainPresenter {
    
    //MARK: - Properties
    
    weak var view: MainViewProtocol?
    private let router: RouterProtocol
    private let network: NetworkService
    
    
    //MARK: - Lifecycle
    
    init(network: NetworkService, router: RouterProtocol) {
        self.network = network
        self.router = router
    }
}


//MARK: - Internal Methods

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        network.fetchTrending { result in
            switch result {
            case .success(let recipes):
                let items = recipes.map(BRListItem.init)
                let section = BRListSection.trending(items)
                DispatchQueue.main.async {
                    self.view?.render(sections: [section])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func performActionForHeader(at index: Int) {
        switch index {
        case 0:
            router.showTrending()
            //            print(sections[index].title)
        case 3:
            break
            //            print(sections[index].title)
        case 4:
            break
            //            print(sections[index].title)
        default:
            break
        }
    }
    
    
    func addToFavorites() {
        print("add to favorites tapped")
    }
    
    
    func removeFromFavorites() {
        print("remove to favorites tapped")
    }
}
