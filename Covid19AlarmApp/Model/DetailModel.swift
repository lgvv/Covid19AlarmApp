//
//  DataStroe.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/26.
//

import Foundation

// 네이버 뉴스 API 호출 메소드
class dataManager {
    static let shared : dataManager = dataManager()
    var searchResult : Welcome?
    
    private init() {
        
    }
}

// MARK: - Welcome
struct Welcome: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let originallink: String
    let link: String
    let itemDescription, pubDate: String

    enum CodingKeys: String, CodingKey {
        case title, originallink, link
        case itemDescription = "description"
        case pubDate
    }
}
