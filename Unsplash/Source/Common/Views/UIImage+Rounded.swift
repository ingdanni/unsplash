//
//  UIImage+Rounded.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import UIKit

final class RoundedImage: UIImageView {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = frame.height / 2
	}
}

final class BorderedImage: UIImageView {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = 16
		layer.borderWidth = 0.5
		layer.borderColor = UIColor.white.cgColor
	}
}
