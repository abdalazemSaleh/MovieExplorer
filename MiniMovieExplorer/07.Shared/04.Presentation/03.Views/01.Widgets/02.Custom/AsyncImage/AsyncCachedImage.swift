import UIKit

class AsyncCachedImageView: UIImageView {
    private var imageURL: URL?
    private var placeholder: UIImage?
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    init(placeholder: UIImage? = nil) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.image = placeholder
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func loadImage(from url: URL?) {
        guard let url = url else {
            self.image = placeholder
            activityIndicator.stopAnimating()
            return
        }

        // Set placeholder image
        self.image = placeholder
        activityIndicator.startAnimating()

        // Cache check
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let cachedImage = UIImage(data: cachedResponse.data) {
            self.image = cachedImage
            activityIndicator.stopAnimating()
            return
        }
        
        // Download image asynchronously
        self.imageURL = url
        Task {
            let downloadedImage = await downloadImage(from: url)
            DispatchQueue.main.async {
                if self.imageURL == url {
                    self.image = downloadedImage ?? self.placeholder
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }

    private func downloadImage(from url: URL) async -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            // Cache the response
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))

            return UIImage(data: data)
        } catch {
            print("Error downloading image: \(error)")
            return nil
        }
    }
}
