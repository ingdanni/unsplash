//
//  UICollectionView+Extensions.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/28/20.
//

import UIKit

extension UICollectionView {
	
	func setEmptyMessage(_ message: String) {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
		label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
		label.text = message
		label.textColor = .systemGray2
		label.numberOfLines = 0
		label.textAlignment = .center
		label.sizeToFit()
		self.backgroundView = label
	}

	func clearEmptyMessage() {
		self.backgroundView = nil
	}
}
