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
    private var currentPage = 1
    let pageSize = 25
    var addedBeers = 0
    var downloadedAll = false
    
    init(withNetworkLayer layer: NetworkLayer) {
        self.networkLayer = layer
    }
    
    func getBeers(completion: @escaping BeerModel.GetBeersCompl) {
        networkLayer.getBeers(fromPage: currentPage) { [weak self] beers, error in
            
            guard let beers = beers else {
                completion(false, nil)
                return
            }
            
            self?.addedBeers = beers.count
            
            if let self = self, self.addedBeers < self.pageSize {
                self.downloadedAll = true
            }
            
            self?.beers.append(contentsOf: beers)
            let indexPaths: [IndexPath]?
            
            if let page = self?.currentPage, page > 1 {
                indexPaths = self?.calculateIndexPathsToReload(from: beers)
            } else {
                indexPaths = nil
            }
            
            self?.currentPage += 1
            
            completion(true, indexPaths)
        }
    }
    
    func getRandomBeer(completion: @escaping BeerModel.GetRandomBeerCompl) {
        
        networkLayer.getRandomBeer { [weak self] randomBeer, error in
            
            guard let randomBeer = randomBeer?.first else {
                completion(false)
                return
            }
            
            self?.randomBeer = randomBeer
            completion(true)
        }
    }
    
    private func calculateIndexPathsToReload(from newBeers: [Beer]) -> [IndexPath] {
        let startIndex = beers.count - newBeers.count
        let endIndex = startIndex + newBeers.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
