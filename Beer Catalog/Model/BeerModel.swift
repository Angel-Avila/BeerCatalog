//
//  BeerModel.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

protocol BeerModel {
    typealias GetBeersCompl = (_ success: Bool) -> ()
    var beers: [Beer] { get }
    var randomBeer: Beer { get }
    
    func getBeers(completion: @escaping GetBeersCompl)
    func getRandomBeer(completion: @escaping GetBeersCompl)
}
