//
//  User.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/28/20.
//

import Foundation

// swiftlint:disable all
struct User: Codable {
	let id: String
	let updatedAt: String
	let username, name, firstName: String
	let lastName, twitterUsername: String?
	let portfolioURL: String?
	let bio, location: String?
	let links: UserLinks
	let profileImage: ProfileImage
	let instagramUsername: String?
	let totalCollections, totalLikes, totalPhotos: Int

	enum CodingKeys: String, CodingKey {
		case id
		case updatedAt = "updated_at"
		case username, name
		case firstName = "first_name"
		case lastName = "last_name"
		case twitterUsername = "twitter_username"
		case portfolioURL = "portfolio_url"
		case bio, location, links
		case profileImage = "profile_image"
		case instagramUsername = "instagram_username"
		case totalCollections = "total_collections"
		case totalLikes = "total_likes"
		case totalPhotos = "total_photos"
	}
}

struct UserLinks: Codable {
	let linksSelf, html, photos, likes: String
	let portfolio, following, followers: String

	enum CodingKeys: String, CodingKey {
		case linksSelf = "self"
		case html, photos, likes, portfolio, following, followers
	}
}

struct ProfileImage: Codable {
	let small, medium, large: String
}
