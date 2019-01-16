//
//  BeerTableViewController.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class BeerTableViewController: UIViewController {
    
    let presenter: BeerCollectionPresenter!
    var tableView: UITableView!
    
    init(withPresenter presenter: BeerCollectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = presenter.backgroundColor
        setupTableView()
        presenter.getBeers { [weak self] indexPaths in
            self?.reloadTableView(at: indexPaths)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "BEER CATALOG"
    }
    
    private func reloadTableView(at indexPaths: [IndexPath]?) {
        guard let indexPaths = indexPaths else {
            tableView.reloadData()
            return
        }
        
        let downloadedAllBeers = presenter.model.downloadedAll
        let offset = downloadedAllBeers ? presenter.model.addedBeers: 0
        
        let startIndex = presenter.model.beers.count
        let endIndex = startIndex + presenter.model.pageSize - offset
        let indexPathsModify = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
        
        if !downloadedAllBeers {
            tableView.insertRows(at: indexPathsModify, with: .fade)
        } else {
            tableView.deleteRows(at: indexPathsModify, with: .fade)
        }
    
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: indexPaths)
        tableView.reloadRows(at: indexPathsToReload, with: .fade)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.accessibilityIdentifier = "tvAccessibilityIdentifier"
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.dataSource = presenter
        presenter.registerCells(forTableView: tableView)
        tableView.estimatedRowHeight = BeerCell.expectedWidth * BeerCell.heightMultiplier
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        self.view.addSubview(tableView)
    }
}

extension BeerTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let beer = presenter.beer(forIndex: indexPath.row) else { return }
        let detailsPresenter = BeerDetailsPresenter(withBeer: beer, andModel: presenter.model)
        let detailsController = BeerDetailsViewController(withPresenter: detailsPresenter)
        detailsController.beer = beer
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .agaveGold
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension BeerTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: presenter.isLoadingCell) {
            presenter.getBeers { [weak self] indexPaths in
                self?.reloadTableView(at: indexPaths)
            }
        }
    }
}

extension BeerTableViewController {
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
