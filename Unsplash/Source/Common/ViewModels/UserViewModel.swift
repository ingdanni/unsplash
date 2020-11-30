//
//  UserViewModel.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import Foundation

enum UserViewState {
	case loadingPhotos
	case normal
	case error(String)
}

final class UserViewModel {
	
	var image: String = ""
	var name: String = ""
	var username: String = ""
	var bio: String = ""
	var photosCount: String = ""
	var collectionsCount: String = ""
	var likesCount: String = ""
	var website: String = ""
	var instagram: String = ""
	var twitter: String = ""
	var photos: [Photo] = []
	
	private let user: User
	private let service: APIService
	
	@Published var state: UserViewState = .normal
	
	init(user: User) {
		self.user = user
		self.service = APIService()
		prepareBindings()
		fetchPhotos()
	}
	
	private func prepareBindings() {
		image = user.profileImage.large
		name = user.name
		username = user.username
		bio = user.bio ?? ""
		photosCount = user.totalPhotos.description
		collectionsCount = user.totalCollections.description
		likesCount = user.totalLikes.description
		website = user.portfolioURL ?? ""
		instagram = kInstragramURL.appending(user.instagramUsername ?? "")
		twitter = kTwitterURL.appending(user.twitterUsername ?? "")
	}
	
	func fetchPhotos() {
		state = .loadingPhotos
		service.getUserPhotos(username: user.username, completion: { result in
			switch result {
			case .success(let data):
				self.photos = data
				self.state = .normal
			case .failure(let error):
				switch error {
				case .unknown(let message):
					self.state = .error(message)
				default:
					self.state = .error(error.localizedDescription)
				}
			}
		})
	}
	
}
