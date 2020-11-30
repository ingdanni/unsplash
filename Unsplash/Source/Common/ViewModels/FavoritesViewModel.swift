//
//  FavoritesViewModel.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import Foundation
import Combine

final class FavoritesViewModel {
	
	private let realmManager: RealmManager
	
	var allPhotos: [PhotoViewModel] = []
	var photos: [PhotoViewModel] = []
	
	private var bindings = Set<AnyCancellable>()
	
	@Published var state: PhotoListState = .normal
	
	init(realmManager: RealmManager = RealmManager.shared) {
		self.realmManager = realmManager
		NotificationCenter.default.publisher(for: .updateFavorites)
			.receive(on: RunLoop.main)
			.sink(receiveValue: { _ in
				self.fetchPhotos()
			})
			.store(in: &bindings)
	}
	
	func fetchPhotos() {
		state = .loading
		let favorites = realmManager.get(Favorite.self)
		let decoder = JSONDecoder()
		allPhotos = favorites.map { item -> PhotoViewModel in
			let photo = try? decoder.decode(Photo.self, from: item.data!)
			return PhotoViewModel(photo: photo!)
		}
		photos = allPhotos
		state = photos.isEmpty ? .empty : .normal
	}
	
	func search(text: String) {
		if text.count == 0 {
			photos = allPhotos
			state = .normal
		} else {
			photos = allPhotos.filter {
				$0.user.name.lowercased().contains(text.lowercased()) || $0.user.username.lowercased().contains(text.lowercased())
			}
			state = .searching
		}
	}
}
