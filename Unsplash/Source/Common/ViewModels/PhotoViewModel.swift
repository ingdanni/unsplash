//
//  PhotoViewModel.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import Foundation

final class PhotoViewModel {
	
	private let realmManager = RealmManager.shared
	
	var name: String = ""
	var likes: String = "0"
	var userImage: String = ""
	var image: String = ""
	var thumb: String = ""
	
	var description: String? {
		var string = ""
		string.append(photo.photoDescription ?? (photo.altDescription ?? ""))
		string.append(contentsOf: "\n")
		string.append(contentsOf: photo.width.description)
		string.append(contentsOf: " x ")
		string.append(contentsOf: photo.height.description)
		string.append(contentsOf: "\n")
		string.append(contentsOf: "by: @")
		string.append(contentsOf: photo.user.username)
		string.append(contentsOf: "\n")
		string.append(contentsOf: photo.createdAt.formatAsDate())
		return string
	}
	
	var user: UserViewModel {
		UserViewModel(user: photo.user)
	}
	
	var isFavorite: Bool {
		realmManager.get(Favorite.self, by: "id = '\(photo.id)'").count > 0
	}
	
	private let photo: Photo
	
	init(photo: Photo) {
		self.photo = photo
		prepareBindings()
	}
	
	private func prepareBindings() {
		name = photo.user.name
		likes = photo.likes.description
		userImage = photo.user.profileImage.medium
		image = photo.urls.full
		thumb = photo.urls.thumb
	}
	
	func addToFavorites() {
		if let item = realmManager.get(Favorite.self, by: "id = '\(photo.id)'").first {
			realmManager.delete(object: item)
		} else {
			let favorite = Favorite()
			favorite.id = photo.id
			favorite.data = photo.data
			realmManager.set(favorite)
		}
		
		NotificationCenter.default.post(name: .updateFavorites, object: nil)
	}
}
