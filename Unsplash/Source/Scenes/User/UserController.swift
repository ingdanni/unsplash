//
//  UserController.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit
import Combine

class UserController: UIViewController, StoryboardLoadable {
	
	static var storyboardId: String {
		"UserController"
	}
	
	static var storyboardName: String {
		"Main"
	}
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var bioLabel: UILabel!
	@IBOutlet weak var photosCountLabel: UILabel!
	@IBOutlet weak var collectionsCountLabel: UILabel!
	@IBOutlet weak var likesCountLabel: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	
	var viewModel: UserViewModel!
	
	private var bindings = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
		addBackButton()
		prepareCollectionView()
		prepareUI()
    }
	
	private func prepareUI() {
		imageView.setImage(viewModel.image)
		usernameLabel.text = viewModel.name
		bioLabel.text = viewModel.bio
		photosCountLabel.text = viewModel.photosCount
		collectionsCountLabel.text = viewModel.collectionsCount
		likesCountLabel.text = viewModel.likesCount
		
		viewModel.$state
			.receive(on: RunLoop.main)
			.sink(receiveValue: { state in
				switch state {
				case .error(let message):
					self.alert(message: message)
				default:
					self.collectionView.reloadData()
				}
			})
			.store(in: &bindings)
	}
	
	private func prepareCollectionView() {
		collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
			let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120)))
			item.contentInsets.trailing = 8
			item.contentInsets.leading = 8
			item.contentInsets.bottom = 8
			item.contentInsets.top = 8
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120)), subitems: [item])
			let section = NSCollectionLayoutSection(group: group)
			section.orthogonalScrollingBehavior = .continuous
			section.contentInsets.leading = 0
			section.contentInsets.trailing = 0
			return section
		}
		
		collectionView.register(UserPhotoCell.self)
		collectionView.dataSource = self
	}
	
	private func openUrl(_ url: String) {
		guard url != "", let url = URL(string: url) else { return }
		UIApplication.shared.open(url)
	}
	
	@IBAction func websiteButtonTapped(_ sender: Any) {
		openUrl(viewModel.website)
	}
	
	@IBAction func twitterButtonTapped(_ sender: Any) {
		openUrl(viewModel.twitter)
	}
	
	@IBAction func instagramButtonTapped(_ sender: Any) {
		openUrl(viewModel.instagram)
	}
	
}

extension UserController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPhotoCell.reuseIdentifier, for: indexPath) as? UserPhotoCell
		let url = viewModel.photos[indexPath.row].urls.thumb
		cell!.photoView?.setImage(url)
		return cell!
	}
}
