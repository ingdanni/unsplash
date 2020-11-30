//
//  StoryboardLoadable.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import UIKit

protocol StoryboardLoadable: UIViewController {
	static var storyboardId: String { get }
	static var storyboardName: String { get }
}

// swiftlint:disable force_cast

extension StoryboardLoadable {
	
	static func loadFromStoryboard() -> Self {
		return UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardId) as! Self
	}
	
}
