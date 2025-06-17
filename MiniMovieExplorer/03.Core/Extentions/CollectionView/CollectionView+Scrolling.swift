import UIKit

extension UICollectionView {
    func scrollTo(_ page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
