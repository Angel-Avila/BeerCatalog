//
//  Beer.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

struct Beer: Decodable {
    var name: String?
    var tagline: String?
    var description: String?
    var abv: Double?
    var ibu: Double?
    var srm: Double?
    
    var imageUrl: String?
    var firstBrewed: String?
    var foodPairing: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case name, tagline, description, abv, ibu, srm
        case imageUrl = "image_url"
        case firstBrewed = "first_brewed"
        case foodPairing = "food_pairing"
    }
}
