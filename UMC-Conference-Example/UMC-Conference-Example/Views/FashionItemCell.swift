//
//  FashionItemCell.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import UIKit

final class FashionItemCell: UICollectionViewCell {
  static let reuseId = "FASHION_ITEM_CELL"
  
  private var titleLabel: UILabel = UILabel()
  private var imageView: UIImageView = UIImageView()
  private var sizeLabel: UILabel = UILabel()
  
  // MARK: Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configTitleLabel()
    configImage()
    configSizeLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  public func set(with item: FashionItem) {
    guard let imageUrl = URL(string: item.imageUrl) else { return }
    downloadImage(with: imageUrl)
    titleLabel.text = item.name
    guard let size = item.size else { return }
    sizeLabel.text = size
  }
  
  private func configTitleLabel() {
    addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    titleLabel.textAlignment = .center
    titleLabel.textColor = .label
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.90
    titleLabel.lineBreakMode = .byTruncatingTail
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      titleLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  private func configImage() {
    addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
      imageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
      imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor)
    ])
  }
  
  private func configSizeLabel() {
    addSubview(sizeLabel)
    
    sizeLabel.translatesAutoresizingMaskIntoConstraints = false
    sizeLabel.font = UIFont.systemFont(ofSize: 14)
    sizeLabel.textAlignment = .center
    sizeLabel.textColor = .label
    sizeLabel.adjustsFontSizeToFitWidth = true
    sizeLabel.minimumScaleFactor = 0.90
    sizeLabel.lineBreakMode = .byTruncatingTail
    
    NSLayoutConstraint.activate([
      sizeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      sizeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
      sizeLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  private func downloadImage(with url: URL) {
    let image = Task {
      let (data, response) = try await URLSession.shared.data(from: url)
      guard
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 else { throw FetchImageError.networkError }
      
      guard let image = UIImage(data: data) else { throw FetchImageError.unsupportedImage }
      return image
    }
    
    Task { @MainActor in
      self.imageView.image = try await image.value
    }
  }
}

enum FetchImageError: Error {
  case networkError
  case unsupportedImage
}
