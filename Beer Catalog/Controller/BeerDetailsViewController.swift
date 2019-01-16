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
            setupBeerUI(fromBeer: beer)
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

    private func setupBeerUI(fromBeer beer: Beer) {
        self.title = beer.name ?? "-"
        beerDetailsView.taglineLabel.text = beer.tagline ?? "-"
        
        let abv = beer.abv != nil ? String(beer.abv!) : "-"
        beerDetailsView.abvLabel.text = "ALC/VOL: \(abv)%"
        
        let ibu = beer.ibu != nil ? String(beer.ibu!) : "-"
        beerDetailsView.ibuLabel.text = "IBU's: \(ibu)"
        
        let date = beer.firstBrewed != nil ? beer.firstBrewed! : "-"
        beerDetailsView.brewedDateLabel.text = "DATE: \(date)"
        
        let description = beer.firstBrewed != nil ? beer.description! : "-"
        beerDetailsView.descritionLabel.text = description
        
        let foodPairing = beer.foodPairing != nil ? beer.foodPairing!.joined(separator: ", ") : "-"
        beerDetailsView.foodPairingLabel.text = foodPairing
        
        let srmColor = beer.srm != nil ? beer.srm!.srmColor() : Double(exactly: -1)?.srmColor()
        beerDetailsView.srmColorView.backgroundColor = srmColor
        
        guard let stringUrl = beer.imageUrl, let url = URL(string: stringUrl) else { return }
        
        beerDetailsView.beerImageView.af_setImage(withURL: url)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(beerDetailsView)
        beerDetailsView.fillSuperview()
    }

}
