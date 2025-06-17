import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var posterImageView: AsyncCachedImageView!
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet weak var favButton: FavoriteButton!
    
    func configure(with data: MovieViewItem, favoriteButtonAction: @escaping (Bool) -> Void) {
        posterImageView.loadImage(from: data.movie.posterURL)
        nameLable.text = data.movie.title
        favButton.isFavorited = data.isFavorite
        favButton.onToggle = { isFavorite in
            favoriteButtonAction(isFavorite)
        }
    }
}
