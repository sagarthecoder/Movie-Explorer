//
//  GenreTableViewCell.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    let identifier = GenreListCollectionViewCell.className
    var genres = [GenreInfo]()
    var selectedGenreHandler : ((_ genreInfo : GenreInfo)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: GenreListCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setItems(genres : [GenreInfo]) {
        self.genres = genres
        collectionView.reloadData()
        if !genres.isEmpty {
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
}

extension GenreTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
}

extension GenreTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GenreListCollectionViewCell
        if indexPath.item < genres.count {
            let item = genres[indexPath.item]
            cell.setItem(categoryTitle: item.name ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < genres.count {
            let item = genres[indexPath.item]
            selectedGenreHandler?(item)
        }
    }
}

extension GenreTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.item < genres.count else {
            return CGSize(width: 110, height: 50)
        }
        let text = genres[indexPath.item].name ?? ""
        let textWidth = (text as NSString).textSize(font: .systemFont(ofSize: 17)).width
        return CGSize(width: textWidth + 10, height: 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}


