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
    
    // MARK: - Initialization
    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
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
}
