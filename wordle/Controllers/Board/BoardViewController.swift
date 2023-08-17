

import UIKit

protocol BoardCollectionViewDataSource: AnyObject {
  var currentGuesses: [[Character?]] { get }
  var currentGuessesBackground: [[UIColor?]] { get }
}

class BoardViewController: UIViewController, UICollectionViewDelegateFlowLayout {

  let spaceBetweenItems: CGFloat = 5
  weak var dataSource: BoardCollectionViewDataSource?

  private let BoardCollectionView: UICollectionView = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)
    return collectionView
  }()

  override func viewDidLoad(){
    super.viewDidLoad()

    BoardCollectionView.dataSource = self
    BoardCollectionView.delegate = self
    view.addSubview(BoardCollectionView)
    CollectionViewLayout()

  }

   public func reloadData() {
    BoardCollectionView.reloadData()
  }

}


extension BoardViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataSource?.currentGuesses[section].count ?? 0
    }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else { fatalError() }
    cell.BoxLabel.text = nil
    cell.BoxLabel.backgroundColor = .clear
    let guesses = dataSource?.currentGuesses ?? []
    let guessesBackground = dataSource?.currentGuessesBackground ?? []
    if let letter =  guesses[indexPath.section][indexPath.row], let background = guessesBackground[indexPath.section][indexPath.row] {
      cell.configureLetter(letter: letter,background: background)
      

    } 
    return cell
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    dataSource?.currentGuesses.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: calculateItemSize(indexPath.section), height: calculateItemSize(indexPath.section))
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

    UIEdgeInsets(top: 0, left: itemsSideSpace(section), bottom: spaceBetweenItems, right: itemsSideSpace(section))
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    spaceBetweenItems
  }
}


//MARK: - Private

extension BoardViewController {

  private func CollectionViewLayout() {
    
    NSLayoutConstraint.activate([
      BoardCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
      BoardCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      BoardCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      BoardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
    ])

  }

  private func calculateItemSize(_ section: Int ) -> CGFloat {
    let size: CGFloat = (BoardCollectionView.frame.width / CGFloat(dataSource?.currentGuesses[section].count ?? 0)) - spaceBetweenItems
    return size < 60 ? size : 60
  }

  private func itemsSideSpace(_ section: Int ) -> CGFloat {
    (BoardCollectionView.frame.width - ((calculateItemSize(section) + spaceBetweenItems) * CGFloat(dataSource?.currentGuesses[section].count ?? 0))) / 2
  }
}
