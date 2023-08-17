

import UIKit


 
class BoardCollectionViewCell: UICollectionViewCell {

  static let identifier = "BoardCell"

  let BoxView: UIView = {
    let view: UIView = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
  
    return view
  }()

  let BoxLabel: UILabel = {
    let label: UILabel = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemGray6
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 40, weight: .medium)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(BoxView)
    BoxView.addSubview(BoxLabel)
    boxLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureLetter(letter: Character,background: UIColor?) {
    BoxLabel.text = letter.uppercased()
    BoxLabel.backgroundColor = background
  }
  
}

//MARK: - Private

extension BoardCollectionViewCell {

  func boxLayout() {
    NSLayoutConstraint.activate([
      BoxView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      BoxView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      BoxView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
      BoxView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
    ])
    contentView.backgroundColor = .clear
    if let color = UIColor(named: "BoxColor") {
      contentView.layer.borderColor = color.cgColor
      contentView.layer.borderWidth = 3
    }
    NSLayoutConstraint.activate([
      BoxLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      BoxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      BoxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      BoxLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])

  }
}
