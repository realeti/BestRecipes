//
//  BRAuthorsModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 12.07.2024.
//

import UIKit

struct BRAuthorsModel {
    let authorImageName: String?
    
    var image: UIImage? {
        return UIImage(named: authorImageName!)
    }
}
