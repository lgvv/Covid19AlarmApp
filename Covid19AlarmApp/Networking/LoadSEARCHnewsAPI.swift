//
//  LoadSEARCHnewsAPI.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/26.
//

import Foundation
import UIKit

class LoadSEARCHnewsAPI {
    
    static var shared = LoadSEARCHnewsAPI()
    
    let jsconDecoder: JSONDecoder = JSONDecoder()

    func urlTaskDone() {
        let item = dataManager.shared.searchResult?.items[0]
        print(item)
//        do {
//            let imageURL = URL(string: item!.image)
//            let imageData = try Data(contentsOf: imageURL!)
//            let posterImage = UIImage(data: imageData)
//            OperationQueue.main.addOperation {
//                self.posterImageView.image = posterImage
//                self.movieTitleLabel.text = item?.title
//            }
//
//        } catch { }
    }
    
    func requestAPIToNaver(queryValue: String) {
        
        let query: String  = "https://openapi.naver.com/v1/search/news.json?query=\(queryValue)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
       
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKEY, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else { print(error); return }
            guard let data = data else { print(error); return }
            
            do {
                let searchInfo: Welcome = try self.jsconDecoder.decode(Welcome.self, from: data)
                dataManager.shared.searchResult = searchInfo
                self.urlTaskDone()
            } catch {
                print(fatalError())
            }
        }
        task.resume()
    }
}
