//
//  HTTPRequest.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

struct HTTPRequest {
    let endpoint: Endpoint
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let body: Data?

    init(
        endpoint: Endpoint,
        method: HTTPMethod,
        headers: HTTPHeaders? = nil,
        body: Data? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.body = body
    }
}
