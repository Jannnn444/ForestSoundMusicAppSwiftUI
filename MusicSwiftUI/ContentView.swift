//
//  ContentView.swift
//  MusicSwiftUI
//
//  Created by yucian huang on 2024/3/6.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var viewModel: ContentViewModel
    
    
//    @EnvironmentObject var viewModel: ContentViewModel    //important!! to link form our datamodel
     
    
    var body: some View {
        HStack{
           
            //arrowshape.backward
            Button(action: {
               
                viewModel.previousArtist()
            }) {
                Image(systemName: "arrowshape.backward.fill")
                    .tint(.black)
                    .frame(width: 30, height: 30, alignment: .center)
              
            }
          
            
            VStack {
                VStack{
                    Image(systemName: "tent")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .tint(.cyan)
                    Text("Forest Sound")
                        .fontDesign(.serif)
                }
                ScrollView {
                    
                    VStack {
                        ForEach(viewModel.playlists, id: \.self) { playlist in
                            PlaylistRowView(playlist: playlist)
                        }
                    }
//                    .padding()
                }
            }

            // arrowshape.right
            Button(action: {
                viewModel.nextArtist()
                       }) {
                           Image(systemName: "arrowshape.right.fill")
                               .tint(.black)
                               .frame(width: 30, height: 30, alignment: .center)
                       }
           
        }
        
    }
}

struct PlaylistRowView: View {
    
    let playlist: Playlist
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Artist Name: \(playlist.artistName)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                Text("Track Name: \(playlist.trackName)")
                    .fontDesign(.serif)
                   
            }
            
            Spacer()
            
            Button(action: {
                UIApplication.shared.open(playlist.previewUrl)
            }) {
                Image(systemName: "play.fill")
                    .resizable()
                    .tint(.red)
                    .frame(width: 22, height: 22, alignment: .trailing)
                    
            } .padding(.bottom)  //push button red play button upper
            
        }
        .padding()
    }
}

struct ContentContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}















