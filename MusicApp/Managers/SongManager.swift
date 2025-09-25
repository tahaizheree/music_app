//
//  SongManager.swift
//  MusicApp
//
//  Created by Mateen on 17/09/2025.
//

import Foundation
import AVFoundation
import UIKit

protocol SongManagerPlayerViewDelegate {
    func playButtonUIChange(play: Bool)
    func progressBarUIChange(progress :Float)
    func fullDurationUIChange(duration: String)
    func playingDurationUIChange(duration:String)
}

protocol SongManagerHomeViewDelegate {
    func playButtonUIChange(play:Bool)
    func songUIChange(songName: String)
    func progressBarUIChange(progress :Float)
}

class SongManager {
    static var songsArray: [Song] = [
        Song(name: "Believer", image: UIImage(named: "Believer") ?? UIImage(), artist: "Imagine Dragons"),
        Song(name: "Natural", image: UIImage(named: "Natural") ?? UIImage(), artist: "Imagine Dragons"),
        Song(name: "Whatever It Takes", image: UIImage(named: "Whatever It Takes") ?? UIImage(), artist: "Imagine Dragons"),
        Song(name: "Demons", image: UIImage(named: "Demons") ?? UIImage(), artist: "Imagine Dragons"),
        Song(name: "Radioactive", image: UIImage(named: "Radioactive") ?? UIImage(), artist: "Imagine Dragons"),
        Song(name: "Shots", image: UIImage(named: "Shots") ?? UIImage(), artist: "Imagine Dragons"),
        Song(name: "Bad Liar", image: UIImage(named: "Bad Liar") ?? UIImage(), artist: "Imagine Dragons"),
        
        
    ]
    static var player: AVAudioPlayer!
    static var isPlaying: Bool = false
    static var progressTimer: Timer?
    static var songPlaying: String = ""
    static var songPlayingDuration: String = ""
    
    static var playerDelegate : SongManagerPlayerViewDelegate?
    static var homeDelegate : SongManagerHomeViewDelegate?
    
    private init(){
        
    }
    
    static func playSong(name : String){
        if isPlaying && name != songPlaying {
            progressTimer?.invalidate()
            player.stop()
            songPlaying = name
            
            playerDelegate?.playButtonUIChange(play: true)
            homeDelegate?.playButtonUIChange(play: true)
            homeDelegate?.songUIChange(songName: name)
            playSound(soundName: name)
            updateDuration()
        }
        else {
            if isPlaying {
                player.pause()
                isPlaying = false
                playerDelegate?.playButtonUIChange(play: false)
                homeDelegate?.playButtonUIChange(play: false)
                progressTimer?.invalidate()
            } else {
                if player == nil {
                    homeDelegate?.songUIChange(songName: name)
                    playSound(soundName: name )
                    songPlaying = name
                    updateDuration()
                } else if name != songPlaying  {
                    songPlaying = name
                    homeDelegate?.songUIChange(songName: name)
                    playSound(soundName: name )
                    
                } else {
                    startProgressTimer()
                    player.play()
                }
                isPlaying = true
                playerDelegate?.playButtonUIChange(play: true)
                homeDelegate?.playButtonUIChange(play: true)
            }
        }
    }
    
    
    static func forward10Seconds (){
        player.currentTime += 10
    }
    
    
    static func backward10Seconds (){
        player.currentTime -= 10
    }
    
    static func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            SongManager.player = try AVAudioPlayer(contentsOf: url)
            SongManager.player.play()
            
            startProgressTimer()
        } catch {
            print("Error loading sound: \(error)")
        }
    }
    
    static func updateDuration() {
        let min : Int = Int(player.duration / 60)
        let sec : Int = Int(player.duration) - Int(min * 60)
        
        let paddedMin = min < 10 ? "0\(min)" : "\(min)"
        let paddedSec = sec < 10 ? "0\(sec)" : "\(sec)"
        
        
        songPlayingDuration = "\(paddedMin) : \(paddedSec)"
        playerDelegate?.fullDurationUIChange(duration: songPlayingDuration)
        
    }
    
    
    static func startProgressTimer() {
        SongManager.progressTimer?.invalidate()
        
        SongManager.progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {  _ in
            //            guard let self = self, let player = SongManager.player else { return }
            let progress = Float(player.currentTime / player.duration)
            let min : Int = Int(player.currentTime / 60)
            let sec : Int = Int(player.currentTime) - Int(min * 60)
            
            let paddedMin = min < 10 ? "0\(min)" : "\(min)"
            let paddedSec = sec < 10 ? "0\(sec)" : "\(sec)"
            
            playerDelegate?.playingDurationUIChange(duration: "\(paddedMin) : \(paddedSec)")
            
            playerDelegate?.progressBarUIChange(progress: progress)
            homeDelegate?.progressBarUIChange(progress: progress)
            
            if(progress == 1.0) {
                playerDelegate?.playButtonUIChange(play: false)
            }
        }
    }
    
}
