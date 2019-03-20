//
//  BeerDetailsViewController.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class BeerDetailsViewController: UIViewController {

    let presenter: BeerDetailsPresenter!
    
    lazy var beerDetailsView = BeerDetailsView()
    
    lazy var scrollView: UIScrollView! = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = true
        sv.showsVerticalScrollIndicator = false
        sv.accessibilityIdentifier = "svIdentifier"
        return sv
    }()
    
    var beer: Beer? {
        didSet {
            guard let beer = beer else { return }
            let beerVM = BeerViewModel(from: beer)
            setupBeerUI(fromBeer: beerVM)
        }
    }
    
    init(withPresenter presenter: BeerDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        let barItem = UIBarButtonItem(title: "Random", style: .plain, target: self, action: #selector(getRandomBeerTapped))
        barItem.tintColor = .agaveGold
        navigationItem.rightBarButtonItem = barItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = presenter.backgroundColor
        setupViews()
    }
   
    @objc private func getRandomBeerTapped() {
        presenter.getRandomBeer { [weak self] in
            self?.beer = self?.presenter.model.randomBeer
        }
    }

    private func setupBeerUI(fromBeer beer: BeerViewModel) {
        self.title = beer.name
        beerDetailsView.taglineLabel.text = beer.tagline
        beerDetailsView.abvLabel.text = beer.abv
        beerDetailsView.ibuLabel.text = beer.ibu
        beerDetailsView.brewedDateLabel.text = beer.date
        beerDetailsView.descritionLabel.text = beer.description
        beerDetailsView.foodPairingLabel.text = beer.foodPairing
        beerDetailsView.srmColorView.backgroundColor = beer.srmColor
        
        guard let url = beer.url else { return }
        
        beerDetailsView.beerImageView.af_setImage(withURL: url)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(beerDetailsView)
        beerDetailsView.fillSuperview()
    }

}
