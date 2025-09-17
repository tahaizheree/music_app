//
//  SongTableViewCell.swift
//  MusicApp
//
//  Created by Mateen on 17/09/2025.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    @IBOutlet weak var songThumbnail: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var songArtistName: UILabel!
    
    
    public func configure(songThumbnail: UIImage, songName: String, songArtistName: String){
        self.songThumbnail.image = songThumbnail
        self.songName.text = songName
        self.songArtistName.text = songArtistName
    }
    
    static func nib()-> UINib {
        return UINib(nibName: "SongTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
}
