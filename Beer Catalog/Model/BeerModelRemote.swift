//
//  BeerModelRemote.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

class BeerModelRemote: BeerModel {
    
    var beers: [Beer] = []
    var randomBeer: Beer = Beer()
    let networkLayer: NetworkLayer
    
    init(withNetworkLayer layer: NetworkLayer) {
        self.networkLayer = layer
    }
    
    func getBeers(completion: @escaping BeerModel.GetBeersCompl) {
        networkLayer.getBeers { [weak self] beers, error in
            
            guard let beers = beers else {
                completion(false)
                return
            }
            
            self?.beers = beers
            completion(true)
        }
    }
    
    func getRandomBeer(completion: @escaping BeerModel.GetBeersCompl) {
        
        networkLayer.getRandomBeer { [weak self] randomBeer, error in
            
            guard let randomBeer = randomBeer?.first else {
                completion(false)
                return
            }
            
            self?.randomBeer = randomBeer
            completion(true)
        }
    }
}
