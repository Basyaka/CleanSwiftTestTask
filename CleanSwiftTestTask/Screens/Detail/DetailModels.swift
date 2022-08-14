//
//  DetailModels.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

enum Detail {
    enum Initial {
        struct Request {}
        
        struct Response {
            let title: String
            let description: String
            let image: UIImage
        }
        
        struct ViewModel {
            let title: String
            let description: String
            let image: UIImage
        }
    }
}
