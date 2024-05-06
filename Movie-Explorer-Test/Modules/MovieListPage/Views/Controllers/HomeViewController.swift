//
//  HomeViewController.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var viewModel : MovieListViewModel!
    var isFirstTimeLoaded = true
    let genreIdentifier = GenreTableViewCell.className
    let moviewItemIdentifier = MovieItemTableViewCell.className
    var selectedGenreID = 28
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstTimeLoaded {
            isFirstTimeLoaded = false
            view.layoutIfNeeded()
            setupViews()
        }
    }
    
    private func bindViewModel() {
        viewModel = MovieListViewModel(movieRepository: WebMovieRepository())
    }
    
    private func setupViews() {
        setupTableViews()
    }
    
    private func setupTableViews() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = tableView.layoutMargins

        let genreNib = UINib(nibName: GenreTableViewCell.className, bundle: nil)
        let movieItemNib = UINib(nibName: MovieItemTableViewCell.className, bundle: nil)
        tableView.register(genreNib, forCellReuseIdentifier: genreIdentifier)
        tableView.register(movieItemNib, forCellReuseIdentifier: moviewItemIdentifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
//        tableView.sectionHeaderHeight = 40
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    

}

extension HomeViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: genreIdentifier, for: indexPath) as! GenreTableViewCell
            viewModel.getGenres { genres in
                DispatchQueue.main.async {
                    cell.setItems(genres: genres)
                }
            }
            cell.selectedGenreHandler = { [weak self] genreInfo in
                guard let strongSelf = self, let genreID = genreInfo.id else {
                    return
                }
                DispatchQueue.main.async {
                    strongSelf.selectedGenreID = genreID
                    tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                }
            }
            cell.layoutIfNeeded()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: moviewItemIdentifier, for: indexPath) as! MovieItemTableViewCell
            viewModel.getMovies(genreID: selectedGenreID) { movies in
                DispatchQueue.main.async {
                    cell.setItems(movies: movies)
                }
            }
            cell.layoutIfNeeded()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: moviewItemIdentifier, for: indexPath) as! MovieItemTableViewCell
            viewModel.getPopularMovies { movies in
                DispatchQueue.main.async {
                    cell.setItems(movies: movies)
                }
            }
            cell.layoutIfNeeded()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerHeight = getHeaderHeight(section: section)
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        let leading = 16.0
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: leading),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ])
        label.text = (section == 2) ? "Popular" : ""
        label.textColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 2:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch section {
        case 0:
            return 50
        default:
            return 214
        }
    }
    
    private func getHeaderHeight(section : Int)-> CGFloat {
        switch section {
        case 0:
            return 50
        default:
            return 214
        }
    }
   
}

