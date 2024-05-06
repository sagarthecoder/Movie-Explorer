//
//  GenreListCollectionViewCell.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import UIKit

class GenreListCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.backgroundColor = UIColor.systemPink.cgColor
                layer.cornerRadius = 10
            } else {
                layer.backgroundColor = UIColor.clear.cgColor
                layer.cornerRadius = 0
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryTitleLabel.text = ""
    }
    
    func setItem(categoryTitle : String) {
        self.categoryTitleLabel.text = categoryTitle
    }

}
