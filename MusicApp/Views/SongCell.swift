//
//  SongCell.swift
//  MusicApp
//
//  Created by Mateen on 16/09/2025.
//

import UIKit

class SongCell: UICollectionViewCell {

    
    
    var shadowColors : [CGColor] = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.white.cgColor, UIColor.purple.cgColor, UIColor.orange.cgColor]
    @IBOutlet weak var songThumbnail: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var songArtistName: UILabel!
    
    @IBOutlet weak var imageContainer: UIView!
    
    
    public func configure(with image: UIImage,name songName: String, artist: String){
        songThumbnail.image = image
        self.songName.text = songName
        self.songArtistName.text = artist
    }
    
    static func nib()-> UINib {
        return UINib(nibName: "SongCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageContainer.layer.shadowColor = shadowColors[Int.random(in: 0...5)]
        imageContainer.layer.shadowOpacity = 0.25
        imageContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageContainer.layer.shadowRadius = 6
        imageContainer.layer.masksToBounds = false
        
    }

}
