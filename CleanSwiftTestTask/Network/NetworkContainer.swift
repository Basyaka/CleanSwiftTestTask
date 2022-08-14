//
//  NetworkContainer.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import Foundation

final class NetworkContainer {
    // MARK: - Shared
    static let shared = NetworkContainer()
    
    // MARK: - Properties
    let httpClient: HTTPClientProtocol
    let imageDownloader: ImageDownloaderProtocol
    
    // MARK: - Initialization
    private init(
        httpClient: HTTPClientProtocol = HTTPClient(),
        imageDownloader: ImageDownloaderProtocol = ImageDownloader()
    ) {
        self.httpClient = httpClient
        self.imageDownloader = imageDownloader
    }
}
