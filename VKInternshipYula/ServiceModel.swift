//
//  ServiceModel.swift
//  VKInternshipYula
//
//  Created by Тимур Жексимбаев on 30.03.2024.
//

import Foundation

    
struct Model: Decodable {
    var body: Services?
}

struct Services: Decodable {
    var services: [ServiceModel]?
}

struct ServiceModel: Decodable, Hashable {
    var name: String?
    var description: String?
    var link: String?
    var icon_url: String?
}
