//
//  CollectionViewMainCell.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import UIKit

final class CollectionViewMainCell: UICollectionViewCell, CollectionViewCellProtocol {
    // MARK: - Nested Types
    struct Model: CollectionViewCellModelProtocol {
        var callbackAction: ((Model) -> Void)?
        let title: String
        let subtitle: String
        let image: UIImage
        
        init(title: String, subtitle: String, image: UIImage) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
        }
    }
    
    private enum Constants {
        static let contentOffset: CGFloat = 8
        
        // Border customization parameters
        static let borderWidth: CGFloat = 1.5
        static let borderColor: CGColor = UIColor.black.cgColor
        static let cornerRadius: CGFloat = 8
    }
    
    // MARK: - Properties
    var model: Model! {
        didSet {
            titleLabel.text = model.title
            subtitileLabel.text = model.subtitle
            imageView.image = model.image
        }
    }
    
    // MARK: - UIProperties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView.prepareForAutoLayout()
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let subtitileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel,
            subtitileLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView.prepareForAutoLayout()
    }()
    
    // MARK: - Initialization
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        setupCustomization()
    }

    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(contentStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.contentOffset
            ),
            contentStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.contentOffset
            ),
            contentStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.contentOffset
            ),
            contentStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Constants.contentOffset
            ),
            
            imageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupCustomization() {
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor
        layer.cornerRadius = Constants.cornerRadius
    }
}
