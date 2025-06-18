import UIKit

class ProductionCompanyCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var companyImageView: AsyncCachedImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    // MARK: - Configure
    func configure(with company: ProductionCompany) {
        /// some logos don't work in dark mode
        companyImageView.loadImage(from: company.logoURL)
        companyNameLabel.text = company.name
    }
}
