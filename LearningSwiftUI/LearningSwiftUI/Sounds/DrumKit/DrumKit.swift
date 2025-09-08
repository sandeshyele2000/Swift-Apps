//
//  SoundEffects.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 07/09/25.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()  // Singleton instance
    
    private var player: AVAudioPlayer?
    
    private init() {} // Prevents creating SoundManager() outside
    
    // This is not needed, directly access SoundManager.instance
    static func getInstance() -> SoundManager {
        return instance
    }
    
    func playSound(soundName: String, fileType: String = "mp3") {
        // Find file in the app bundle
        guard let url = Bundle.main.url(forResource: soundName, withExtension: fileType) else {
            print("Sound file not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

struct DrumKit: View {
        
    var body: some View {
        VStack(spacing: 10) {
            DrumKit()
        }
        .padding()
        .overlay {
            Text("Drum Kit")
                .rotationEffect(Angle(degrees: 90))
                .offset(x: 30, y: 0)
                .font(.title)
                .underline()
        }
    }
    
    @ViewBuilder
    func DrumKit() -> some View {
        if let crash = UIImage(named: "crash.png") {
            ImageView(uiImage: crash, name: "crash")
                .scaleEffect(3.5)
                .offset(x: -40, y: -20)
        }
                    
        if let tom3 = UIImage(named: "tom3.png") {
            ImageView(uiImage: tom3, name: "tom3")
                .scaleEffect(1.5)
                .offset(x: -130)
        }
        
        if let tom1 = UIImage(named: "tom1.png") {
            ImageView(uiImage: tom1, name: "tom1")
                .scaleEffect(1.8)
                .offset(x: 90, y: -50)
        }
        
        if let kick = UIImage(named: "kick.png") {
            ImageView(uiImage: kick, name: "kick")
                .offset(x: -50, y: 0)
                .scaleEffect(3)
        }
        
        if let tom2 = UIImage(named: "tom2.png") {
            ImageView(uiImage: tom2, name: "tom2")
                .scaleEffect(1.8)
                .offset(x: 90, y: 40)
        }
        
        if let tom4 = UIImage(named: "tom4.png") {
            ImageView(uiImage: tom4, name: "tom4")
                .scaleEffect(1.5)
                .offset(x: -130, y: -10)
        }
        
        if let snare = UIImage(named: "snare.png") {
            ImageView(uiImage: snare, name: "snare")
                .scaleEffect(2.4)
                .offset(x: -90, y: 10)
        }
    }

    func ImageView(uiImage: UIImage, name: String) -> some View {
        
       Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(90))
            .blendMode(.multiply)
            .onTapGesture {
                SoundManager.instance.playSound(soundName: name)
            }
    }

}

#Preview {
    DrumKit()
}
