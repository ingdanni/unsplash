//
//  ViewController.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/25/20.
//

import UIKit
import Combine

class HomeController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	private var bindings = Set<AnyCancellable>()
	
	private var viewModel: HomeViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Images"
		prepareSearch()
		prepareCollectionView()
		prepareViewModel()
	}
	
	private func prepareViewModel() {
		viewModel = HomeViewModel()
		viewModel.fetchPhotos()
		viewModel.$state
			.receive(on: RunLoop.main)
			.sink(receiveValue: { _ in
				// TO-DO: handle state
				self.collectionView.reloadData()
			})
			.store(in: &bindings)
	}
	
	private func prepareCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(PhotoCollectionViewCell.self)
		collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
			let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140)))
			item.contentInsets.trailing = 8
			item.contentInsets.leading = 8
			item.contentInsets.bottom = 8
			item.contentInsets.top = 8
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(140)), subitems: [item])
			let section = NSCollectionLayoutSection(group: group)
			section.contentInsets.leading = 0
			section.contentInsets.trailing = 0
			return section
		}
	}
	
	func prepareSearch() {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
	}

}

extension HomeController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell ?? PhotoCollectionViewCell()
		cell.viewModel = viewModel.photos[indexPath.row]
		return cell
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		// TO-DO: Prevent fetching several times .reachedBottom State
		if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
			switch viewModel.state {
			case .normal:
				viewModel.fetchPhotos()
			default:
				break
			}
		}
	}
}

extension HomeController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let controller = PhotoDetailController.loadFromStoryboard()
		controller.viewModel = viewModel.photos[indexPath.row]
		navigationController?.pushViewController(controller, animated: true)
	}
}

extension HomeController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text {
			viewModel.search(text: searchText)
		}
	}
}
