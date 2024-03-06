//
//  ContentView.swift
//  MusicSwiftUI
//
//  Created by yucian huang on 2024/3/6.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        
        VStack {
            HStack{
                Image(systemName: "tent")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .tint(.cyan)
                Text("Forest Sound")
            }
            
            Spacer()
            Text("Artist Name: \(viewModel.playlists.first?.artistName ?? "")")
            Text("Track Name: \(viewModel.playlists.first?.trackName ?? "")")
//            Text("Preview URL: \(viewModel.playlists.first?.previewUrl.absoluteString ?? "")")
            Button(action: {
                guard let url = viewModel.playlists.first?.previewUrl else {
                    print("Preview URL is not available")
                    return
                }
                UIApplication.shared.open(url)
            }) {
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .tint(.red)
            }
            .padding()
            
        }
        .padding()
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
