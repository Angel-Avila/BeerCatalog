//
//  Beer.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class BeerObject: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var tagline: String
    @NSManaged var desc: String
    @NSManaged var abv: NSNumber
    @NSManaged var ibu: NSNumber
    @NSManaged var srm: NSNumber
    
    @NSManaged var imageUrl: String
    @NSManaged var firstBrewed: String
    @NSManaged var foodPairing: [String]
}

class BeerViewModel {
    
    var name: String!
    var tagline: String!
    var abv: String!
    var ibu: String!
    var date: String!
    var description: String!
    var foodPairing: String!
    var srmColor: UIColor!
    var url: URL?
    
    init(from beer: BeerObject) {
        self.name = beer.name
        self.tagline = beer.tagline
        
        let abv = beer.abv.stringValue
        self.abv = "ALC/VOL: \(abv)%"
        
        let ibu = beer.ibu.stringValue
        self.ibu = "IBU's: \(ibu)"
        
        self.date = beer.firstBrewed
        
        self.description = beer.description
        
        self.foodPairing = beer.foodPairing.joined(separator: ", ")
        
        self.srmColor = beer.srm.doubleValue.srmColor()
        
        self.url = URL(string: beer.imageUrl)
    }
    
    init(from beer: Beer) {
        self.name = beer.name != nil ? beer.name! : "-"
        self.tagline = beer.tagline != nil ? beer.tagline! : "-"
        
        let abv = beer.abv != nil ? String(beer.abv!) : "-"
        self.abv = "ALC/VOL: \(abv)%"
        
        let ibu = beer.ibu != nil ? String(beer.ibu!) : "-"
        self.ibu = "IBU's: \(ibu)"
        
        self.date = beer.firstBrewed != nil ? beer.firstBrewed : "-"
        
        self.description = beer.description != nil ? beer.description : "-"
        
        self.foodPairing = beer.foodPairing != nil ? beer.foodPairing!.joined(separator: ", ") : "-"
        
        self.srmColor = beer.srm != nil ? beer.srm!.srmColor() : Double(exactly: -1)?.srmColor()
        
        self.url = beer.imageUrl != nil ? URL(string: beer.imageUrl!) : nil
    }

}

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
