import UIKit

final class MovieCollectionViewLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    private let padding: CGFloat = 20
    private let spacing: CGFloat = 8
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        scrollDirection = .vertical
        minimumLineSpacing = spacing
        minimumInteritemSpacing = spacing
        sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    // MARK: - Layout
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width - (padding * 2) - spacing
        let itemWidth = availableWidth / 2
        itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
    }
} 