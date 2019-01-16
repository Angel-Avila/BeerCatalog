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
    
    func getBeers(completion: @escaping ((_ indexPaths: [IndexPath]?) -> ())) {
        self.model.getBeers { success, indexPaths in
            if success {
                completion(indexPaths)
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
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= model.beers.count
    }
}


extension BeerCollectionPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !model.downloadedAll {
            return beers.count + model.pageSize
        }
        
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BeerCell
        
        if !isLoadingCell(for: indexPath) {
            cell.beer = beers[indexPath.row]
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.accessibilityIdentifier = "cell\(indexPath.row)"
        
        return cell
    }
}
