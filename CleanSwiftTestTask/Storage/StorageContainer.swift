//
//  StorageContainer.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import Foundation

final class StorageContainer {
    // MARK: - Shared
    static let shared = StorageContainer()
    
    // MARK: - Properties
    let realmService: RealmService
    let fileService: FileServiceProtocol
    
    // MARK: - Initialization
    private init(
        realmService: RealmService = RealmService(),
        fileService: FileServiceProtocol = FileService()
    ) {
        self.realmService = realmService
        self.fileService = fileService
    }
}
