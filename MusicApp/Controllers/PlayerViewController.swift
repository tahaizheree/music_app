//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Mateen on 17/09/2025.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    var song: Song?
    var songIndex: Int?
    var isSameSongCheck : Bool {
        return SongManager.songPlaying == song?.name
    }
    
    @IBOutlet weak var songThumbnail: UIImageView!
    
    
    @IBOutlet weak var songName: UILabel!
    
    
    @IBOutlet weak var artistName: UILabel!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    
    
    @IBOutlet weak var totalDurationTime: UILabel!
    
    
    @IBOutlet weak var playingDurationTime: UILabel!
    
    
    
    @IBOutlet weak var songProgress: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        songThumbnail.image = song?.image
        songName.text = song?.name
        artistName.text = song?.artist
        if (SongManager.isPlaying && SongManager.songPlaying == song?.name) {
            playButtonUIChange(play: true)
        }
        if(SongManager.songPlaying == song?.name) {
            fullDurationUIChange(duration: SongManager.songPlayingDuration)
        }
        SongManager.playerDelegate = self
    }
    

    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        SongManager.playSong(name: song!.name)
    }

    
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        
        if(SongManager.isPlaying && isSameSongCheck) {
            SongManager.forward10Seconds()
        }
    }
    
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
        if(SongManager.isPlaying && isSameSongCheck) {
            SongManager.backward10Seconds()
        }
    }
    
    
    
    @IBAction func nextSongButtonPressed(_ sender: UIButton) {
         songIndex  = songIndex! + 1 >= SongManager.songsArray.count ? 0 : songIndex! + 1
        
        song = SongManager.songsArray[songIndex!]
        songThumbnail.image = song?.image
        songName.text = song?.name
        artistName.text = song?.artist
        SongManager.playSong(name: song!.name)
    }
    
    
    @IBAction func previousSongButtonPressed(_ sender: UIButton) {
        songIndex  = songIndex! - 1 <=  0 ? SongManager.songsArray.count - 1 : songIndex! - 1
       
       song = SongManager.songsArray[songIndex!]
       songThumbnail.image = song?.image
       songName.text = song?.name
       artistName.text = song?.artist
       SongManager.playSong(name: song!.name)
    }
    
    
    
    
    
    
    
    
    
    
}



extension PlayerViewController : SongManagerPlayerViewDelegate {
    func fullDurationUIChange(duration: String) {
        totalDurationTime.text = duration
    }
    
    func playingDurationUIChange(duration: String) {
        if(isSameSongCheck){
            playingDurationTime.text = duration
        }
    }
    
    func playButtonUIChange(play: Bool) {
        if(!play) {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func progressBarUIChange(progress: Float) {
        if (SongManager.songPlaying == song?.name) {
            songProgress.progress = progress
        }
      
    }
    
    
}
