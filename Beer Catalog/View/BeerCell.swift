//
//  BeerCell.swift
//  Beer Catalog
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import AlamofireImage

class BeerCell: UITableViewCell {

    static let expectedWidth = (UIScreen.main.bounds.width / 4) - (5 * 8)
    static let heightMultiplier: CGFloat = (16/9)
    var beer: BeerViewModel? {
        didSet {
            guard let beer = beer else { return }
            nameLabel.text = beer.name
            taglineLabel.text = beer.tagline
            //taglineLabel.text = "Lorem ipsum dolor sit amet consectetur adipiscing elit, eleifend senectus hac arcu commodo tellus cum, leo lacus justo fusce taciti sociis. Cras sociis ante aptent nulla mattis porta cubilia sollicitudin, dis phasellus id scelerisque dictum per sagittis tristique, duis taciti sed tempus varius pharetra hac. Turpis sociosqu massa netus est sociis venenatis metus dui facilisis cubilia diam natoque interdum, arcu duis porttitor at nec molestie eleifend aenean mi neque sem laoreet, tempus nascetur mus mollis feugiat praesent maecenas varius pretium pulvinar integer pellentesque."
            
            guard let url = beer.url else { return }
            
            beerImageView.af_setImage(withURL: url)
        }
    }
    
    lazy var nameLabel = Label(fontName: "AvenirNext-DemiBold", size: 21, textColor: .agaveGold)
    lazy var taglineLabel = Label(size: 17, textColor: .black)
    
    lazy var beerImageView: UIImageView! = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        // 8 padding, 3 times
        let width = BeerCell.expectedWidth
        let height = width * BeerCell.heightMultiplier
        iv.anchorSize(size: CGSize(width: width, height: height))
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let vp: CGFloat = 16
        
        addSubview(beerImageView)
        beerImageView.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 24, bottom: vp, right: 0))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: self.topAnchor, leading: beerImageView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: vp, left: 8, bottom: 0, right: 8))
        
        addSubview(taglineLabel)
        
        taglineLabel.anchor(top: nameLabel.bottomAnchor, leading: beerImageView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: vp, left: 8, bottom: 0, right: 8))
        
        beerImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: vp).isActive = true
        taglineLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -vp).isActive = true
    }
}
