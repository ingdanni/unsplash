//
//  UIImageView+Extensions.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit
import Kingfisher

extension UIImageView {
	
	func setImage(_ url: String, contentMode: ContentMode = .scaleAspectFill, placeholder: String? = nil) {
		
		self.image = nil
		
		if let placeholder = placeholder {
			self.image = UIImage(named: placeholder)
			self.contentMode = .scaleAspectFit
		}
		
		if url != "", let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
			self.contentMode = contentMode
			self.kf.setImage(with: url, completionHandler: { result in
				switch result {
				case .success:
					break
				case .failure:
					print("---> Error fetching image: \(url)")
				}
			})
		}
	}
}
