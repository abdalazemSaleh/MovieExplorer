import UIKit

class MovieDetailsCard: BaseComponent {
    
    // MARK: - IBOUTLET
    @IBOutlet weak var moviePosterImageView: AsyncCachedImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRunningTimeLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    // MARK: - Proeprties
    var movie: MovieDetails? {
        didSet {
            guard let movie = movie else { return }
            moviePosterImageView.loadImage(from: movie.posterURL)
            movieTitleLabel.text = movie.title
            movieRunningTimeLabel.text = movie.formattedRuntime
            movieReleaseDateLabel.text = movie.releaseDate
        }
    }
    
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
    }
}
