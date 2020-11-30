//
//  HTTPClient.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/25/20.
//

import Foundation

enum APIError: Error {
	case forbidden
	case notFound
	case internalError
	case decoding(String)
	case unknown(String)
}

final class HTTPClient {
	
	private let urlSession: URLSession
	private let token: String
	private let url: String
	
	init(urlSession: URLSession = .shared, url: String = kServiceURL, token: String = kServiceToken) {
		self.urlSession = urlSession
		self.token = token
		self.url = url
	}
	
	func get<E: Codable>(path: String, type: E.Type, completion: @escaping (Result<E, APIError>) -> Void) {
		let requestUrl = URL(string: url.appending(path))!
		var request = URLRequest(url: requestUrl)
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue(token, forHTTPHeaderField: "Authorization")
		let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
			if let response = response as? HTTPURLResponse {
				switch response.statusCode {
				case 200..<300:
					if let data = data {
						do {
							let decodedResponse = try JSONDecoder().decode(type, from: data)
							completion(.success(decodedResponse))
						} catch {
							completion(.failure(.decoding(error.localizedDescription)))
						}
					} else {
						completion(.failure(.notFound))
					}
				case 400..<403:
					completion(.failure(.forbidden))
				case 404:
					completion(.failure(.notFound))
				case 500..<505:
					completion(.failure(.internalError))
				default:
					completion(.failure(.unknown("An unexpected error ocurred")))
				}
			}
			if let error = error {
				completion(.failure(.unknown(error.localizedDescription)))
			}
		})
		task.resume()
	}
}
