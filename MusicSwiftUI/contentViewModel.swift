//
//  contentViewModel.swift
//  MusicSwiftUI
//
//  Created by yucian huang on 2024/3/6.
//
import SwiftUI
import Foundation



struct Playlist: Identifiable {
    
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
    
    init(){
        fetchArtoist(singer: "birdy")
    }
    
    
    func fetchArtoist(singer: String) {
        let urlString = "https://itunes.apple.com/search?term=\(singer)&media=music&country=tw"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        print("Fetching music...")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
        
            guard let data = data else {
                print("No data received")
                return
            }
            
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
       
        
    }
    
 
}
