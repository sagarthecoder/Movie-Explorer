//
//  MovieItemTableViewCell.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let identifier = MoviePosterCollectionViewCell.className
    var movies = [MovieInfo]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        let nib = UINib(nibName: MoviePosterCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setItems(movies : [MovieInfo]) {
        self.movies = movies
        collectionView.reloadData()
        if !movies.isEmpty {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    func getPosterURL(path : String?)-> URL? {
        guard let path = path else {
            return nil
        }
        let urlString = APIConfig.posterBaseURL + path
        return URL(string: urlString)
    }
    
}

extension MovieItemTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
}

extension MovieItemTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MoviePosterCollectionViewCell
        if indexPath.item < movies.count {
            let item = movies[indexPath.item]
            if let posterURL = getPosterURL(path: item.posterPath) {
                Task {
                    let image = try await ImageDownloadManager.shared.downloadImage(from: posterURL)
                    DispatchQueue.main.async {
                        cell.setPoster(image: image)
                    }
                }
            }
        }
        return cell
    }
    
}

extension MovieItemTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 213.33)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

