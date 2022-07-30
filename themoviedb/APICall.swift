//
//  APICall.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import Foundation
import UIKit

class APICall {
    
    func fetchShows(trend: String = "trending", type: String = "movie", completionHandler: @escaping ([MovieModel], Error?) -> Void) {
        
        var url = URL(string: "\(APIConstants.baseUrl)/\(trend)/\(type)\(trend == "trending" ? "/day" : "")?api_key=\(APIConstants.apiKey)")!
        
        if trend == "popular" {
            url = URL(string: "\(APIConstants.baseUrl)/\(type)/\(trend)?api_key=\(APIConstants.apiKey)")!
        }

        print("look here")
        print(url.absoluteString)
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                completionHandler([], error)
            }

            if let data = data,
               let shows = try? JSONDecoder().decode(MovieList.self, from: data) {
                print("hey jan \n\(shows.items)")
                completionHandler(shows.items, nil)
            }else{
                let jsonString = String(data: data ?? Data(), encoding: .utf8)!
                print("hey man\n\(jsonString)")
            }
        })
        task.resume()
    }
    
    func fetchReviews(movieId: Int, completionHandler: @escaping ([ReviewModel], Error?) -> Void) {
        
        let url = URL(string: "\(APIConstants.baseUrl)/movie/\(movieId)/reviews?api_key=\(APIConstants.apiKey)")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching reviews: \(error)")
                completionHandler([], error)
            }

            if let data = data,
               let viewers = try? JSONDecoder().decode(ReviewList.self, from: data) {
                print("hey jan \n\(viewers.items)")
                completionHandler(viewers.items, nil)
            }else{
                let jsonString = String(data: data ?? Data(), encoding: .utf8)!
                print("hey man\n\(jsonString)")
            }
        })
        task.resume()
        
    }
    
    func fetchImage(imageView: UIImageView, poster: String, large: Bool = false) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url = NSURL(string: "\(large ? APIConstants.originalImageUrl : APIConstants.smallImageUrl)\(poster)"){

            let task = session.dataTask(with: url as URL, completionHandler: {data, response, error in

                if let err = error {
                    print("Error: \(err)")
                    return
                }

                if let http = response as? HTTPURLResponse {
                    if http.statusCode == 200 {
                        let downloadedImage = UIImage(data: data!)
                        DispatchQueue.main.async {
                            imageView.image = downloadedImage
                        }
                    }
                }
           })
           task.resume()
        }
    }
}
