//
//  UserPhotoCell.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit

class UserPhotoCell: UICollectionViewCell, NibLoadable {
	
	static var reuseIdentifier: String {
		"UserPhotoCell"
	}
	
	static var nib: UINib {
		UINib(nibName: reuseIdentifier, bundle: nil)
	}
	
	@IBOutlet weak var photoView: UIImageView!
}
