//
//  NibLoadable.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit

protocol NibLoadable {
	static var reuseIdentifier: String { get }
	static var nib: UINib { get }
}

extension UITableView {
	func register(_ cell: NibLoadable.Type) {
		self.register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
	}
}

extension UICollectionView {
	func register(_ cell: NibLoadable.Type) {
		self.register(cell.nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
	}
}
