//
//  TabBar.swift
//  Music
//
//  Created by Haris Munir on 9/19/21.
//

import SwiftUI

struct TabBar: View{
    //Selected Tab Index
    //Deafult is third..
    @State var current = 2
    
    //Miniplayer
    @State var expand = false
    
    @Namespace var animation
    
    var body: some View{
        
        //Bottom Mini player...
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom),
               content: {
            
                TabView(selection: $current){
                
                
                    Text("Library")
                        .tag(0)
                        .tabItem {
                            Image(systemName: "rectangle.stack.fill")
                        Text("Library")
                    }
                    Text("Radio")
                        .tag(1)
                        .tabItem {
                            Image(systemName: "dot.radiowaves.left.and.right")
                        Text("Radio")
                    }
                
                    Search()
                        .tag(2)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            } //end Tab View
                Miniplayer(animation: animation, expand: $expand)
                
        })
        
    }
}


/*

 */
