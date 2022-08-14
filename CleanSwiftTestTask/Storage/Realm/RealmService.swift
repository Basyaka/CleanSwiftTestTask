//
//  RealmService.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import Foundation
import RealmSwift

class RealmService {
    // MARK: - Nested Types
    private enum Constants {
        static let realmErrorEventName: String = "RealmError"
    }
    
    // MARK: - Properties
    var realm = try! Realm()
    
    // MARK: - CRUD Methods
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            post(error)
        }
    }
    
    func create<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            post(error)
        }

    }
    
    func read<T: Object>() -> Results<T> {
        realm.objects(T.self)
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                dictionary.forEach { key, value in
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    // MARK: - Error Handling
    func observeRealmErrors(completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(
            forName: Notification.Name(Constants.realmErrorEventName),
            object: nil,
            queue: nil
        ) { notification in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingRealmErrors() {
        NotificationCenter.default.removeObserver(Notification.Name(Constants.realmErrorEventName))
    }
    
    private func post(_ error: Error) {
        NotificationCenter.default.post(name: Notification.Name(Constants.realmErrorEventName), object: error)
    }
}
