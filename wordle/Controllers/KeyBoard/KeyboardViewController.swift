//
//  KeyboardViewController.swift
//  wordle
//
//  Created by Hani on 6/8/2023.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
  func keyboardViewController(
    _ controllerView: KeyboardViewController,
    didTapKey letter: Character
  )
}

protocol KeyboardViewControllerDataSource: AnyObject {
  func keyColor(letter: Character) -> UIColor?
}

class KeyboardViewController: UIViewController {

  //MARK: - Constants

  private enum Constants {
    static let letters: [String] = ["qwertyuiop","asdfghjkl","zxcvbnm"]
    static let spacingLetters: CGFloat = 2
  }

  //MARK: - Variable

  private var keys: [[Character]] = []

  weak var delegate: KeyboardViewControllerDelegate?
  weak var dataSource: KeyboardViewControllerDataSource?

//MARK: - CollectionView

   private let collectionView: UICollectionView = {

    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = Constants.spacingLetters
    let CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    CollectionView.translatesAutoresizingMaskIntoConstraints = false
    CollectionView.backgroundColor = .clear
    CollectionView.register(KeyCollectionViewCell.self, forCellWithReuseIdentifier: KeyCollectionViewCell.identifier)
    return CollectionView
  } ()


    override func viewDidLoad() {
      super.viewDidLoad()
      initKeys()
      view.backgroundColor = .clear
      collectionView.dataSource = self
      collectionView.delegate = self
      view.addSubview(collectionView)
      collectionConstraint()
    }

  public func reloadData() {
    collectionView.reloadData()
  }

}


extension KeyboardViewController: UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    keys[section].count
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    keys.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: KeyCollectionViewCell.identifier,
      for: indexPath) as? KeyCollectionViewCell else { fatalError("error")}
    
    cell.keyLabel.text = String(keys[indexPath.section][indexPath.row])
    if let color = dataSource?.keyColor(letter: keys[indexPath.section][indexPath.row]) {
      cell.keyLabel.backgroundColor = color
      if color == .systemGray2 {
        cell.layer.opacity = 0.5
      }
    }

    return cell

  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let margin: CGFloat = 20
    let size: CGFloat = (collectionView.frame.size.width - margin )/10
    return CGSize(width: size, height: size * 1.5)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let margin: CGFloat = 20
    let size: CGFloat = (collectionView.frame.size.width - margin )/10

    let horizontalEdges: CGFloat = (collectionView.frame.size.width - CGFloat(keys[section].count) * size  - ( CGFloat(keys[section].count) * Constants.spacingLetters) )/2

    return UIEdgeInsets(
      top: 2,
      left: horizontalEdges,
      bottom: 2,
      right: horizontalEdges
    )
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let letter = keys[indexPath.section][indexPath.row]
    delegate?.keyboardViewController(self, didTapKey: letter)
  }
}


//MARK: - Private

extension KeyboardViewController {

  private func collectionConstraint() {
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func initKeys() {
    for line in Constants.letters {
      keys.append(Array(line.uppercased()))
    }
  }
}
