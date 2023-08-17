//
//  KeyCollectionViewCell.swift
//  wordle
//
//  Created by Hani on 6/8/2023.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {

  static let identifier: String = "keyCell"

  let keyLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    return label
  }()

  func configure(letter: Character){
    keyLabel.text = String(letter)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .darkGray
    contentView.addSubview(keyLabel)
    keyLabel.isUserInteractionEnabled = true
    NSLayoutConstraint.activate([
      keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      keyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      keyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    ])
    keyLabel.textAlignment = .center
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
