//
//  Search.swift
//  Music
//
//  Created by Haris Munir on 9/20/21.
//

import SwiftUI
import AVKit

struct Search: View {
    
    @State var search = ""
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View{
        
        ScrollView{
            
            VStack(spacing: 18){
            
                HStack{
                    
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                }
                
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    
                    TextField("Search", text: $search)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(15)
                
                // Grid View Of Songs...
                
                LazyVGrid(columns: columns,spacing: 20){
                    
                    ForEach(1...10, id: \.self){index in
                        
                            
                        Button(action: {
                            
                        
                        }){
                            Image("\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                            
                            // two side padding = 30
                            //spacing = 20
                            // total = 50
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 180) .cornerRadius(15)
                    }
                    
                }
                .padding(.top, 10)
            }
            .padding()
            
            //padding miniplayer size as bottom..
            .padding(.bottom, 80)
        }
    }
}

