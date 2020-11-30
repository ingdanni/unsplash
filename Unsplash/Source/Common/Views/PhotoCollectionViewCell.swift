//
//  PhotoCollectionViewCell.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit
import Combine

class PhotoCollectionViewCell: UICollectionViewCell, NibLoadable {
	
	static var reuseIdentifier: String {
		"PhotoCollectionViewCell"
	}
	
	static var nib: UINib {
		UINib(nibName: reuseIdentifier, bundle: nil)
	}
	
	var viewModel: PhotoViewModel! {
		didSet {
			prepareUI()
		}
	}
	
	private var bindings = Set<AnyCancellable>()
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var likesLabel: UILabel!
	@IBOutlet weak var favoritesButton: UIButton!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	private func prepareUI() {
		imageView.setImage(viewModel.thumb)
		userImageView.setImage(viewModel.userImage)
		usernameLabel.text = viewModel.name
		likesLabel.text = viewModel.likes
		setFavoriteButton()
		
		NotificationCenter.default.publisher(for: .updateFavorites)
			.receive(on: RunLoop.main)
			.sink(receiveValue: { _ in
				self.setFavoriteButton()
			})
			.store(in: &bindings)
	}
	
	private func setFavoriteButton() {
		let heart = UIImage(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
		favoritesButton.setImage(heart, for: .normal)
	}
	
	@IBAction func favoritesButtonTapped(_ sender: UIButton) {
		viewModel.addToFavorites()
	}

}
