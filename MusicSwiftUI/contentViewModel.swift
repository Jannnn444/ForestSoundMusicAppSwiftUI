//
//  contentViewModel.swift
//  MusicSwiftUI
//
//  Created by yucian huang on 2024/3/6.
//
import SwiftUI
import Foundation



struct Playlist: Identifiable, Hashable {
    
    var id: UUID = UUID()
    
    let artistName: String
    let trackName: String
    let previewUrl: URL
    
}

struct SearchResponse: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let artistName: String
    let trackName: String
    let previewUrl: URL
}


class ContentViewModel: ObservableObject {
    
    @Published var playlists: [Playlist] = []
    @Published var artistIndex: Int = 0
    @Published var artistNames = ["birdy", "maroon5", "lanadelrey"]
    
    init(){
       
        fetchArtist(artistName: artistNames[artistIndex])
    }
    
    
    func fetchArtist(artistName: String) {
       // for artistName in artistNames {
            let urlString = "https://itunes.apple.com/search?term=\(artistName)&media=music&country=tw"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            print("Fetching music for \(artistName)...")
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                print("Getting Response")
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                print("Getting Data")
                
                do {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(SearchResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.playlists = response.results.map { result in
                            Playlist( artistName: result.artistName, trackName: result.trackName, previewUrl: result.previewUrl)
                        }
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }

            }.resume()
            print("Decoding and fetching on the mainthread, please wait...")
    
       // }
        
      
    }
    func nextArtist() {
        artistIndex = (artistIndex + 1) % artistNames.count 
        fetchArtist(artistName: artistNames[artistIndex])
        }
    
    
   func previousArtist() {
       
       artistIndex = (artistIndex + artistNames.count - 1) % artistNames.count
       fetchArtist(artistName: artistNames[artistIndex])
       }
    
}
