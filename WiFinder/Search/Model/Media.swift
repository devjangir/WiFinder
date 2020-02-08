//
//  Media.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 28/01/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import Foundation
enum MediaType : Int {
    case music
    case tvshow
    case movie
    func description() -> String {
        switch  self {
            case .music: return "music"
            case .movie: return "movie"
            case .tvshow: return "tvshow"
        }
    }
}

protocol Mediable : Decodable {
    var artworkUrl100 : String {get set}
//    var mediaName : String { get set }
//    var mediaDescription: String { get set }
//    - artistName for tvShow or trackName for music and movie
//    - longDescription for tvShow and movie, artistName for music
}

struct Media : Decodable {
    var artworkUrl100: String
    var trackName: String?
    var longDescription: String?
    var artistName: String?
    var previewUrl: String?
    enum CodingKeys: String, CodingKey {
        case artworkUrl100, trackName, longDescription, artistName, previewUrl
    }
}

////Music Model to story music information?
//struct Music : Mediable {
//    var artworkUrl100: String = ""
//    var mediaName: String = ""
//    var mediaDescription: String = ""
//    enum CodingKeys: String, CodingKey {
//        case artworkUrl100 = "artworkUrl100"
//        case mediaName = "trackName"
//        case mediaDescription = "artistName"
//    }
//}
//
////Movie Model to story music information
//struct Movie : Mediable {
//    var artworkUrl100: String = ""
//    var mediaName: String = ""
//    var mediaDescription: String = ""
//    enum CodingKeys: String, CodingKey {
//        case artworkUrl100 = "artworkUrl100"
//        case mediaName = "trackName"
//        case mediaDescription = "longDescription"
//    }
//}
//
////TVShow Model to story music information
//struct TVShow : Mediable {
//    var artworkUrl100: String = ""
//    var mediaName: String = ""
//    var mediaDescription: String = ""
//    enum CodingKeys: String, CodingKey {
//        case artworkUrl100 = "artworkUrl100"
//        case mediaName = "artistName"
//        case mediaDescription = "longDescription"
//    }
//}
struct MediaResults : Decodable {
    var resultCount: Int
    var results : [Media]
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
}
