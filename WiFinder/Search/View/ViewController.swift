//
//  ViewController.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 28/01/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import UIKit
import AVKit
import JGProgressHUD
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var searchViewModel : SearchViewModel = SearchViewModel()
    //add searchcontroller
    var searchController : UISearchController?
    //searchToText
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Media"
        
        //add searchcontroller to search media
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search Media ..."
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.searchBarStyle = .prominent
        searchController?.searchBar.scopeButtonTitles = ["Music", "Movie", "TvShow"]
        searchController?.searchBar.delegate = self

        //add searchcontroller to navigation
        navigationItem.searchController = searchController
    }

    func getSearchedMedia(_ searchMedia : String) {
        hud.show(in: self.view)
        searchViewModel.getSearchResult(searchMedia) { [weak self] in
            self?.tableView.reloadData()
            self?.hud.dismiss()
        }
    }
    //open and play preview URL
    func playPreviewURL(_ model: Media) {
        if let strPreview = model.previewUrl,
            let urlPreview = URL(string: strPreview) {
            let player = AVPlayer(url: urlPreview)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackCell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        trackCell.configureCell(model: searchViewModel.tracks[indexPath.row], type: 0)
        return trackCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = searchViewModel.tracks[indexPath.row]
        playPreviewURL(model)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK : SearchBar Delegate
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getSearchedMedia(searchBar.text ?? "")
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchViewModel.selectedMediaType = selectedScope
        self.getSearchedMedia(searchBar.text ?? "")
    }
}

extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}
