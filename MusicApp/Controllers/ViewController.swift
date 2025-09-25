//
//  ViewController.swift
//  MusicApp
//
//  Created by Mateen on 16/09/2025.
//

import UIKit

class ViewController: UIViewController {
        
   
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var playerSongName: UILabel!
    
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    
    @IBOutlet weak var allSongsTableView: UITableView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    @IBOutlet weak var bottomBar: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recommendedCollectionView.register(SongCell.nib(), forCellWithReuseIdentifier: "SongCell")
        allSongsTableView.register(SongTableViewCell.nib(), forCellReuseIdentifier: "SongTableViewCell")
        
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        recommendedCollectionView.showsHorizontalScrollIndicator = false
        
        
        bottomBar.isHidden = true
        
        
        allSongsTableView.delegate = self
        allSongsTableView.dataSource = self
        allSongsTableView.showsVerticalScrollIndicator = false
        
        
      

        SongManager.homeDelegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     
        super.viewWillAppear(animated)
      print("1")
        DispatchQueue.main.sync {
            print("3")
        }
        print("4")
        

    }
    
    
    @IBAction func playerPlayButtonPressed(_ sender: UIButton) {
        SongManager.playSong(name: SongManager.songPlaying)
    }
    


}

//MARK - CollectionView Delegates
extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "PlayerView") as! PlayerViewController
        vc.song = SongManager.songsArray[indexPath.row]
        vc.songIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}




extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SongManager.songsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath) as! SongCell
        
        cell.configure(with: SongManager.songsArray[indexPath.row].image, name: SongManager.songsArray[indexPath.row].name, artist: SongManager.songsArray[indexPath.row].artist)
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // Size of each cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }

    // Horizontal spacing between cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    // Vertical spacing between rows
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }

    // Section insets (padding around the whole section)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}




extension ViewController : SongManagerHomeViewDelegate {
    func playButtonUIChange(play: Bool) {
        if(!play) {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func progressBarUIChange(progress: Float) {
            progressView.progress = progress
    }
    
    func songUIChange(songName: String) {
        bottomBar.isHidden = false
        playerSongName.text = songName
        print("Updated")
        let song = SongManager.songsArray.first { song in
            song.name == songName
        }
        
        playerImageView.image = song?.image
    }
}



extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "PlayerView") as! PlayerViewController
        vc.song = SongManager.songsArray[indexPath.row]
        vc.songIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SongManager.songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        
        let song = SongManager.songsArray[indexPath.row]
        cell.configure(songThumbnail: song.image, songName: song.name, songArtistName: song.artist)

        return cell
    }
    
    
}


