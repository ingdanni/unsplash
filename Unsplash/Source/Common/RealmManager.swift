//
//  RealmManager.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/27/20.
//

import RealmSwift

final class RealmManager {
	
	static let shared = RealmManager()
	
	private var realm: Realm {
		do {
			let realm = try Realm()
			return realm
		} catch {
			print("Could not access database: \(error.localizedDescription)")
		}
		
		return self.realm
	}
	
	func getRealmRouteFile() {
		print("REALM FILE: \(String(describing: realm.configuration.fileURL))")
	}
	
	func get<T: Object>(_ type: T.Type, by filter: String = "", sortBy: String = "", sortAscending: Bool = true) -> [T] {
		let results: Results<T>
		
		if filter.isEmpty {
			if !sortBy.isEmpty {
				results = realm.objects(T.self).sorted(byKeyPath: sortBy, ascending: sortAscending)
			} else {
				results = realm.objects(T.self)
			}
		} else {
			if !sortBy.isEmpty {
				results = realm.objects(T.self).filter(filter).sorted(byKeyPath: sortBy, ascending: sortAscending)
			} else {
				results = realm.objects(T.self).filter(filter)
			}
		}
		
		return Array(results)
	}
	
	func set<T: Object>(_ object: T) {
		do {
			try realm.write {
				realm.add(object, update: .modified)
			}
		} catch {
			print("Could not write to database: \(error.localizedDescription)")
		}
	}
	
	func update(updates: @escaping () -> Void) {
	   do {
		   try realm.write {
			   updates()
		   }
	   } catch {
		   print("Could not write to database: \(error.localizedDescription)")
	   }
	}
	
	func delete(object: Object) {
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			print("Could not write to database: \(error.localizedDescription)")
		}
	}
	
}
