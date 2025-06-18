//
//  GenreCollectionViewCell.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 18/06/2025.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    
    func configure(with genre: String) {
        genreLabel.text = genre
    }
}
