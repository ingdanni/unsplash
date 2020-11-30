//
//  String+Extensions.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import Foundation

extension String {
	func formatAsDate() -> String {
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let date = inputFormatter.date(from: self)
		let outputFormatter = DateFormatter()
		outputFormatter.dateFormat = "MMM dd, yyyy"
		return outputFormatter.string(from: date!)
	}
}

extension NSNotification.Name {
	static let updateFavorites = NSNotification.Name("UPDATE_FAVORITES")
}
