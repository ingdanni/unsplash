//
//  Favorite.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import RealmSwift

// swiftlint:disable all
class Favorite: Object {
	@objc dynamic var id: String = ""
	@objc dynamic var data: Data? = nil
	@objc dynamic var createdAt: Date = Date()
	
	override class func primaryKey() -> String? {
		"id"
	}
}
