//
//  PhotoDetailController.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit
import Closures
import Combine

class PhotoDetailController: UIViewController, StoryboardLoadable {
	
	static var storyboardId: String { "PhotoDetailController" }
	
	static var storyboardName: String { "Main" }
	
	var viewModel: PhotoViewModel!
	
	private var bindings = Set<AnyCancellable>()
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var userLabel: UILabel!
	@IBOutlet weak var likesLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var favoriteButton: UIButton!
	@IBOutlet weak var userView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addBackButton()
		prepareUI()
	}
	
	private func prepareUI() {
		imageView.setImage(viewModel.image)
		userImageView.setImage(viewModel.userImage)
		likesLabel.text = viewModel.likes.appending(" Likes")
		userLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
		setFavoriteButton()
		
		userView.addTapGesture(handler: { _ in
			let controller = UserController.loadFromStoryboard()
			controller.viewModel = self.viewModel.user
			self.navigationController?.pushViewController(controller, animated: true)
		})
		
		favoriteButton.onTap {
			self.viewModel.addToFavorites()
		}
		
		NotificationCenter.default.publisher(for: .updateFavorites)
			.receive(on: RunLoop.main)
			.sink(receiveValue: { _ in
				self.setFavoriteButton()
			})
			.store(in: &bindings)
	}
	
	private func setFavoriteButton() {
		let heart = UIImage(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
		favoriteButton.setImage(heart, for: .normal)
	}
}
