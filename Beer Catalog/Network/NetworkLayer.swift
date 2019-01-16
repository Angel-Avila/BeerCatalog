//
//  NetworkLayer.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    typealias GetBeersCompletion = ([Beer]?, Error?) -> ()
    func getBeers(completion: @escaping GetBeersCompletion)
    func getRandomBeer(completion: @escaping GetBeersCompletion)
}
