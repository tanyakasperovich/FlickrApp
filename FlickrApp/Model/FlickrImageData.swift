//
//  FlickrImageData.swift
//  FlickrApp
//
//  Created by Татьяна Касперович on 20.09.23.
//

import Foundation

// MARK: - FlickrImagesData
struct FlickrImagesData: Codable {
    let photos: Photos
    let extra: Extra
    let stat: String
}

// MARK: - Extra
struct Extra: Codable {
    let exploreDate: String
    let nextPreludeInterval: Int
    
    enum CodingKeys: String, CodingKey {
        case exploreDate = "explore_date"
        case nextPreludeInterval = "next_prelude_interval"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let urlZ: String
    let heightZ, widthZ: Int
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
}
