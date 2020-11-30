//
//  HomeViewState.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/26/20.
//

import Foundation

enum PhotoListState {
	case loading
	case normal
	case searching
	case empty
	case error(String)
}
