//
//  CoinDetailModel.swift
//  Crypto
//
//  Created by Sandesh on 20/12/25.
//

import Foundation


struct CoinDetail: Codable {
    let id, symbol, name: String?
    let links: Links?
    let description: Description?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let previewListing: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, links, description
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm  = "hashing_algorithm"
        case previewListing = "preview_listing"
    }
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}

struct Description: Codable {
    let en: String?
}
