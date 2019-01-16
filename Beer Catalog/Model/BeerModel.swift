//
//  BeerModel.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

protocol BeerModel {
    typealias GetBeersCompl = (_ success: Bool, _ indexPaths: [IndexPath]?) -> ()
    typealias GetRandomBeerCompl = (_ success: Bool) -> ()
    var beers: [Beer] { get }
    var randomBeer: Beer { get }
    var pageSize: Int { get }
    var addedBeers: Int { get }
    var downloadedAll: Bool { get }
    
    func getBeers(completion: @escaping GetBeersCompl)
    func getRandomBeer(completion: @escaping GetRandomBeerCompl)
}
