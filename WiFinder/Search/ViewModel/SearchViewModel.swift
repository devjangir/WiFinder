//
//  SearchViewModel.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 28/01/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import Foundation
class SearchViewModel {
    var tracks : [Media] = []
    var httpService = HttpService()
    var selectedMediaType: Int = 0
    typealias Observer = () -> Void

    func getSearchResult(_ searchText: String, observer: @escaping Observer) {
        httpService.getSearchResults(searchTerm: searchText, mediaType: self.getSelectedMedia()) {[weak self] (trackResult, errorMessage) in
            if let trackList = trackResult {
                self?.tracks = trackList
                observer();
            }
        }
    }

    func getSelectedMedia() -> String {
        if(selectedMediaType == 0) { return "music" }
        else if (selectedMediaType == 1) { return "movie" }
        else { return "tvShow" }
    }
}
