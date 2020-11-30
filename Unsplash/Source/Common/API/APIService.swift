//
//  APIService.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/25/20.
//

import Foundation

final class APIService {
	
	let client: HTTPClient
	
	init() {
		self.client = HTTPClient()
	}
	
	func getPhotos(page: Int, completion: @escaping (Result<[Photo], APIError>) -> Void) {
		client.get(path: "/photos?page=\(page)", type: [Photo].self, completion: completion)
	}
	
	func getUserPhotos(username: String, completion: @escaping (Result<[Photo], APIError>) -> Void) {
		client.get(path: "/users/\(username)/photos", type: [Photo].self, completion: completion)
	}
}
