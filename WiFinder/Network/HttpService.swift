//
//  HttpService.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 28/01/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Query Service
//
class HttpService {
    // default session
    let defaultSession = URLSession(configuration: .default)
    // datatask to download media track
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var tracks: [Media] = []
    var mediaResult : MediaResult?

    // MARK: - Type Alias
    typealias MediaResult = ([Media]?, String) -> Void

    // get result with search query
    func getSearchResults(searchTerm: String, mediaType: String, completion: @escaping MediaResult) {
        // 1
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "media=\(mediaType)&term=\(searchTerm)"
            guard let url = urlComponents.url else {
                return
            }
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }

                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self?.parseSearchResults(data)
                    DispatchQueue.main.async {
                        completion(self?.tracks, self?.errorMessage ?? "")
                    }
                }
            }
            dataTask?.resume()
        }
    }

    //
    private func parseSearchResults(_ data: Data) {
        tracks.removeAll()
        do {
                let result = try JSONDecoder().decode(MediaResults.self, from: data)
                tracks = result.results;
        } catch let parseError as NSError {
            errorMessage += "Decoding error: \(parseError.localizedDescription)\n"
            return
        }
    }
}

