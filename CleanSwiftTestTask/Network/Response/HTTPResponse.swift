//
//  HTTPResponse.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

struct HTTPResponse {
    let statusCode: Int
    let headers: HTTPHeaders
    let data: Data?

    init(
        statusCode: Int,
        headers: HTTPHeaders,
        data: Data?
    ) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }
}
