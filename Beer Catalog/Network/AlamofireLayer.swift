//
//  AlamofireLayer.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Alamofire

class AlamofireLayer: NetworkLayer {

    let throttler = Throttler(seconds: 1)
    
    let beersURL = URL(string: "https://api.punkapi.com/v2/beers")!
    let randomBeerURL = URL(string: "https://api.punkapi.com/v2/beers/random")!
    
    func getBeers(completion: @escaping NetworkLayer.GetBeersCompletion) {
        
        request(url: beersURL, method: .get, completion: completion)
    }
    
    func getRandomBeer(completion: @escaping NetworkLayer.GetBeersCompletion) {
        request(url: randomBeerURL, method: .get, completion: completion)
    }
    
    private func request(url: URL, method: HTTPMethod, completion: @escaping NetworkLayer.GetBeersCompletion) {
        
        throttler.throttle {
            Alamofire.request(url, method: method).responseJSON { response in
                
                switch response.result {
                case .success(_):
                    
                    guard let data = response.data else {
                        completion(nil, nil)
                        return
                    }
                    
                    do {
                        let beers = try JSONDecoder().decode([Beer].self, from: data)
                        completion(beers, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
