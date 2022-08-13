//
//  MainWorker.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

final class MainWorker: MainWorkerLogic {
    // MARK: - Properties
    private let httpClient: HTTPClientProtocol
    private let imageDownloader: ImageDownloaderProtocol
    
    // MARK: - Initialization
    init(
        httpClient: HTTPClientProtocol = HTTPClient(),
        imageDownloader: ImageDownloaderProtocol = ImageDownloader()
    ) {
        self.httpClient = httpClient
        self.imageDownloader = imageDownloader
    }
    
    // MARK: - MainWorkerLogic
    func loadProducts(completion: @escaping ((Result<MainDTO.Response, HTTPError>) -> Void)) {
        let request = HTTPRequest(
            endpoint: MainEndpoint.list,
            method: .get
        )
        
        httpClient.request(request: request) { result in
            let completion = { response in
                DispatchQueue.main.async { completion(response) }
            }
            switch result {
            case .success(let response):
                guard
                    response.statusCode == 200,
                    let data = response.data
                else {
                    completion(.failure(.unsuccessStatus(response.statusCode)))
                    return
                }
                do {
                    let response: MainDTO.Response = try JSONDecoder().decode(
                        MainDTO.Response.self,
                        from: data
                    )
                    completion(.success(response))
                } catch {
                    completion(.failure(.parsingError))
                }
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
    
    func loadImages(
        with products: [MainDTO.Product],
        completion: @escaping (Result<[String:Data], HTTPError>) -> Void
    ) {
        var temporaryStorage: [String:Data] = [:]
        
        let queue = DispatchQueue.global(qos: .utility)
        let group = DispatchGroup()
        
        queue.async {
            products.forEach { product in
                guard let url = URL(string: product.image) else {
                    completion(.failure(.incorrectUrl))
                    return
                }
                
                group.enter()
                
                self.imageDownloader.fetchImage(with: url) { result in
                    switch result {
                    case .success(let data):
                        temporaryStorage[product.image] = data
                        group.leave()
                    case .failure:
                        completion(.failure(.imageDownloadingFail))
                        return
                    }
                }
            }
            
            group.notify(queue: .main) {
                completion(.success(temporaryStorage))
            }
        }
    }
}
