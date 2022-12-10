//
//  MiniPlayer.swift
//  Music
//
//  Created by Haris Munir on 9/20/21.
//

/* TO DO
 - Figure out what is wrong with Dynamic title logic
 - Make buttons more UI Friendly
 
 */

import SwiftUI
import AVKit


struct Miniplayer: View{
    
    @State var audioPlayer: AVAudioPlayer!
    @State var isplay = false
    @State var count = 1
    @State var currentSong = "Pokemon Journeys"

    
    var animation: Namespace.ID
    @Binding var expand: Bool
    
    var height = UIScreen.main.bounds.height / 3
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    //Volume Slider ...
    @State var volume: CGFloat = 0
    
    //gesture Offset...
    @State var offset: CGFloat = 0
    
    
    var body: some View{
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, expand ? safeArea?.top : 0)
                .padding(.vertical, expand ? 30 : 0)
            
            HStack(spacing:15){
                
                // centering Image...
                
                if expand{Spacer(minLength: 0)}
                
                Image ("\(count)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height : 55, height: expand ? height : 55)
            
                if !expand{
                   
                    //Edge of Dawn
                    Text(self.currentSong)
                        .font(.title2)
                        .fontWeight(.bold)
                        .scaledToFit()
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                
                Spacer(minLength: 0)
                
               
                if !expand{

                    Button(action: {
                        playPause()
                    }, label: {
                        
                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                    
                    Button(action: {
                        next()
                    }, label: {
                        
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                }
                
            }
            .padding(.horizontal)
            
            VStack (spacing: 15){
                
                Spacer(minLength:  0)
                
                HStack{
                    if expand{
                        //Edge of Dawn
                        Text(self.currentSong)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .scaledToFit()
                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    
                    Spacer(minLength:  0)
                    
                    Button(action: {}){
                        
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                .padding(.top, 20)
                
                //Live String...
                
                HStack{
                    
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7), Color.primary.opacity(0.1)])
                            , startPoint: .leading, endPoint: .trailing)
                        
                        )
                        .frame(height: 4)
                    
                    Text("Live")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7), Color.primary.opacity(0.7)])
                            , startPoint: .leading, endPoint: .trailing)
                        
                        )
                        .frame(height: 4)
                }
                .padding()
                
                //Stop / Play button...
                HStack{
                    Button(action: {
                        back()
                    }, label: {
                        
                        Image(systemName: "backward.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                    
                    Button(action: {
                        playPause()
                    }){
                        
                        Image(systemName: "stop.fill")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    
                    Button(action: {
                        next()
                    }, label: {
                        
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                }
                
                
                Spacer(minLength: 0)
                
                HStack(spacing: 15){
                    
                    Image(systemName: "speaker.fill")
                    Slider(value: $volume)
                    Image(systemName: "speaker.wave.2.fill")
                }
                .padding()
                
                HStack(spacing: 22){
                    
                    Button(action: {}){
                        
                        Image(systemName: "arrow.up.message")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {}){
                        
                        Image(systemName: "airplayaudio")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {}){
                        
                        Image(systemName: "list.bullet")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }.padding(.bottom, safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
                
            }
            //this will give stretch effect...
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .onAppear{
            let sound = Bundle.main.path(forResource: "\(count)", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
            
            // expand to full screen when clicked..
            .frame(maxHeight: expand ? .infinity: 80)
            
            //Divider Line for seperating miniplayer and tbat bar
            .background(
                
                VStack(spacing: 0){
                    
                    BlurView()
                    
                    Divider()
                }.onTapGesture(perform: {
                    withAnimation(.spring()){
                        expand = true
                }
            })
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .ignoresSafeArea()
    }
    
    func onchanged(value: DragGesture.Value){
        
        //only allowing when its expanded..
        if value.translation.height > 0  && expand {
            
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value){
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            
            //if  value is > than height / 3 then closing
            
            if value.translation.height > height{
                
                expand = false
            }
            offset = 0
        }
        
    }
    
    func next(){
        if self.count < 10{
            self.count += 1
            getTitle(value: count)
        }
        else{
            self.count = 1
            getTitle(value: count)
        }
        let sound = Bundle.main.path(forResource: "\(self.count)", ofType: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        self.audioPlayer.play()
    }
    
    func back(){
        if self.count > 1{
            self.count -= 1
            getTitle(value: count)
        }
        else{
            self.count = 10
            getTitle(value: count)
        }
        let sound = Bundle.main.path(forResource: "\(self.count)", ofType: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        self.audioPlayer.play()
    }
    
    func playPause() {
        if (self.isplay){
            self.audioPlayer.pause()
            self.isplay = false;
        } else {
            self.audioPlayer.play()
            self.isplay = true;
        }
    }
    
    func setCount(value: Int) {
        self.count = value;
    }
    
    func getTitle(value: Int){
        
        switch value{
            case 1:
                self.currentSong = "Pokemon Journeys"
                break
            
            case 2:
                self.currentSong = "The Beginning"
                break
            
            case 3:
                self.currentSong = "Tales of Arise"
                break
            
            case 4:
                self.currentSong = "The Madness Inside"
                break
            
            case 5:
                self.currentSong = "Centuries"
                break
            
            case 6:
                self.currentSong = "Invincible"
                break
            
            case 7:
                self.currentSong = "My War"
                break
            
            case 8:
                self.currentSong = "Come with me Now"
                break
            
            case 9:
                self.currentSong = "Last One Standing"
                break
            
            case 10:
                self.currentSong = "Rex Incognito"
                break
            
            default:
                break
        }
    }
}
