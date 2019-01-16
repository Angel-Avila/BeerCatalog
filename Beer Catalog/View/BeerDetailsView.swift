//
//  BeerDetailsView.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class BeerDetailsView: UIView {
    
    lazy var taglineLabel = Label(size: 17, textColor: .black)
    
    lazy var descritionLabel = Label(fontName: "AvenirNext-DemiBold", size: 17, textColor: .agaveGold)
    lazy var brewedDateLabel = Label(size: 17, textColor: .black)
    lazy var abvLabel = Label(size: 17, textColor: .black)
    lazy var ibuLabel = Label(size: 17, textColor: .black)
    lazy var srmLabel = Label(size: 17, textColor: .black)
    lazy var foodPairingLabel = Label(size: 17, textColor: .black)
    
    lazy var srmColorView: UIView! = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        let height: CGFloat = 20
        view.anchorSize(size: CGSize(width: height, height: height))
        view.layer.cornerRadius = height/2
        return view
    }()
    
    lazy var beerImageView: UIImageView! = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.accessibilityIdentifier = "beerAccesibilityId"
        return iv
    }()
    
    lazy var srmContainerView: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(srmLabel)
        view.addSubview(srmColorView)
        srmLabel.anchorCenterY(to: view)
        srmLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -9).isActive = true
        srmColorView.anchorCenterY(to: view)
        srmColorView.anchor(top: nil, leading: srmLabel.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        return view
    }()
    
    lazy var infoStackView: UIStackView! = {
        let stackView = UIStackView(arrangedSubviews: [brewedDateLabel, abvLabel, ibuLabel, srmContainerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var separatorView: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .agaveGold
        let height: CGFloat = 1
        view.anchorSize(size: CGSize(width: 0, height: height))
        return view
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = "beerDetailsView"
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        anchorSize(size: CGSize(width: UIScreen.main.bounds.width, height: 0))
        setupTop()
        setupBeerInfo()
        setupBottom()
    }
    
    private func setupTop() {
        addSubview(taglineLabel)
        taglineLabel.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        taglineLabel.anchorCenterX(to: self)
    }
    
    private func setupBeerInfo() {
        srmLabel.text = "COLOR"
        
        let hp: CGFloat = 20
        let vp: CGFloat = 20
        
        let imageWidth: CGFloat = (UIScreen.main.bounds.width / 3.5)
        let imageHeight: CGFloat = imageWidth * (2.5)
        
        addSubview(beerImageView)
        beerImageView.anchor(top: taglineLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: vp, left: hp, bottom: 0, right: 0), size: CGSize(width: imageWidth, height: imageHeight))
        
        addSubview(infoStackView)
        infoStackView.anchorCenterY(to: beerImageView)
        infoStackView.anchor(top: nil, leading: beerImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: hp, bottom: 0, right: hp))
        
        addSubview(separatorView)
        separatorView.anchor(top: beerImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: vp, left: 0, bottom: 0, right: 0))
    }
    
    private func setupBottom() {
        let hp: CGFloat = 20
        let vp: CGFloat = 20
        
        descritionLabel.textAlignment = .justified
        foodPairingLabel.textAlignment = .justified
        
        addSubview(descritionLabel)
        descritionLabel.anchor(top: separatorView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: vp, left: hp, bottom: 0, right: hp))
        
        addSubview(foodPairingLabel)
        foodPairingLabel.anchor(top: descritionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: vp, left: hp, bottom: vp, right: hp))
    }
}
