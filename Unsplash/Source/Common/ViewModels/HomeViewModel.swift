//
//  HomeViewModel.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import Combine

final class HomeViewModel {
	
	private let service: APIService
	private var page: Int = 0
	
	var allPhotos: [PhotoViewModel] = []
	var photos: [PhotoViewModel] = []
	
	@Published var state: PhotoListState = .normal
	
	init(service: APIService = APIService()) {
		self.service = service
	}
	
	func fetchPhotos() {
		page += 1
		state = .loading
		service.getPhotos(page: page, completion: { [weak self] result in
			switch result {
			case .success(let photos):
				let models = photos.map { PhotoViewModel(photo: $0) }
				self?.allPhotos.append(contentsOf: models)
				self?.photos = self?.allPhotos ?? []
				self?.state = .normal
			case .failure(let error):
				switch error {
				case .unknown(let message):
					self?.state = .error(message)
				default:
					self?.state = .error(error.localizedDescription)
				}
			}
		})
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
