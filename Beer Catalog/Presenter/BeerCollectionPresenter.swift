//
//  BeerCollectionPresenter.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class BeerCollectionPresenter: NSObject {
    let model: BeerModel
    let backgroundColor: UIColor = .white
    
    private var beers: [Beer] {
        return model.beers
    }
    
    private let cellId = "beerCell"
    
    init(withModel model: BeerModel) {
        self.model = model
    }
    
    func getBeers(completion: @escaping (() -> ())) {
        self.model.getBeers { success in
            if success {
                completion()
            } else {
                print("Can't get beers")
            }
        }
    }
    
    func beer(forIndex index: Int) -> Beer? {
        guard index < model.beers.count else { return nil }
        return self.beers[index]
    }
    
    func registerCells(forTableView tableView: UITableView) {
        tableView.register(BeerCell.self, forCellReuseIdentifier: cellId)
    }
}


extension BeerCollectionPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BeerCell
        
        cell.beer = beers[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.accessibilityIdentifier = "cell\(indexPath.row)"
        
        return cell
    }
}
