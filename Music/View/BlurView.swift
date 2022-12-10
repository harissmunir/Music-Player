//
//  BlurView.swift
//  Music
//
//  Created by Haris Munir on 9/20/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable{
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        
        return view
    }
    
    func updateUIView( _ uiView: UIVisualEffectView, context: Context){
        
    }
}
