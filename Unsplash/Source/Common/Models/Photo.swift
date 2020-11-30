//
//  Photo.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/25/20.
//

import Foundation

// swiftlint:disable all

struct Photo: Codable {
	let id: String
	let createdAt, updatedAt: String
	let promotedAt: String?
	let width, height: Int
	let color: String
	let photoDescription, altDescription: String?
	let urls: Urls
	let links: PhotoLinks
	let likes: Int
	let likedByUser: Bool
	let sponsorship: Sponsorship?
	let user: User

	enum CodingKeys: String, CodingKey {
		case id
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case promotedAt = "promoted_at"
		case width, height, color
		case photoDescription = "description"
		case altDescription = "alt_description"
		case urls, links, likes
		case likedByUser = "liked_by_user"
		case sponsorship, user
	}
}

struct PhotoLinks: Codable {
	let linksSelf, html, download, downloadLocation: String

	enum CodingKeys: String, CodingKey {
		case linksSelf = "self"
		case html, download
		case downloadLocation = "download_location"
	}
}

struct Sponsorship: Codable {
	let impressionUrls: [String]
	let tagline: String
	let taglineURL: String
	let sponsor: User

	enum CodingKeys: String, CodingKey {
		case impressionUrls = "impression_urls"
		case tagline
		case taglineURL = "tagline_url"
		case sponsor
	}
}

struct Urls: Codable {
	let raw, full, regular, small: String
	let thumb: String
}

extension Photo {
	
	var data: Data? {
		return try? JSONEncoder().encode(self)
	}
}
