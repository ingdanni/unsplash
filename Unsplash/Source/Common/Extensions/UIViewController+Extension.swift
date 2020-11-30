//
//  UIViewController+Extension.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import UIKit
import Closures

extension UIViewController {
	
	func addBackButton() {
		let item = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, handler: {
			self.navigationController?.popViewController(animated: true)
		})
		navigationItem.leftBarButtonItem = item
	}
	
	func alert(message: String) {
		let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
}
