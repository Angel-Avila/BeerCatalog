//
//  BeerDetailsPresenter.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class BeerDetailsPresenter {
    let beer: Beer
    let model: BeerModel
    let backgroundColor: UIColor = .white
    
    private var randomBeer: Beer {
        return model.randomBeer
    }
    
    init(withBeer beer: Beer, andModel model: BeerModel) {
        self.beer = beer
        self.model = model
    }
    
    func getRandomBeer(completion: @escaping (() -> ())) {
        self.model.getRandomBeer { success in
            if success {
                completion()
            } else {
                print("Can't get random beer")
            }
        }
    }
 }
