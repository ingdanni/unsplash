//
//  FavoritesController.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import UIKit
import Combine

class FavoritesController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	private var bindings = Set<AnyCancellable>()
	
	private var viewModel: FavoritesViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Favorites"
		prepareSearch()
		prepareCollectionView()
		prepareViewModel()
	}
	
	func prepareSearch() {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
	}
	
	private func prepareViewModel() {
		viewModel = FavoritesViewModel()
		viewModel.fetchPhotos()
		viewModel.$state
			.receive(on: RunLoop.main)
			.sink(receiveValue: { state in
				switch state {
				case .empty:
					self.collectionView.setEmptyMessage("No favorites to show")
				default:
					self.collectionView.clearEmptyMessage()
					self.collectionView.reloadData()
				}
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

}

extension FavoritesController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell ?? PhotoCollectionViewCell()
		cell.viewModel = viewModel.photos[indexPath.row]
		return cell
	}
}

extension FavoritesController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let controller = PhotoDetailController.loadFromStoryboard()
		controller.viewModel = viewModel.photos[indexPath.row]
		navigationController?.pushViewController(controller, animated: true)
	}
}

extension FavoritesController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text {
			viewModel.search(text: searchText)
		}
	}
}
