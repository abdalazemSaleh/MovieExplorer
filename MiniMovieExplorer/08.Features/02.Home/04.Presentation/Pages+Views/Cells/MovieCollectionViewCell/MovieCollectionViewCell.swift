//
//  MovieCollectionViewCell.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var posterImageView: AsyncCachedImageView!
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet weak var favButton: FavoriteButton!
    
    func configure(with data: Movie, favoriteButtonAction: @escaping (Bool) -> Void) {
        posterImageView.loadImage(from: data.posterURL)
        nameLable.text = data.title
        favButton.onToggle = { isFavorite in
            favoriteButtonAction(isFavorite)
        }
    }
}
