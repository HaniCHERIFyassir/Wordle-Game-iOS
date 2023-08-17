//
//  ViewController.swift
//  wordle
//
//  Created by Hani on 4/8/2023.
//

import UIKit

class ViewController: UIViewController {

  let BoardVC = BoardViewController()
  let KeyboardVC = KeyboardViewController()
  var word: String = ["years","happy","small","kings","worry","crazy","shame"].randomElement()!

  var guesses = [[Character?]]()
  var guessesBackground = [[UIColor?]]()
  var orangeKeys = [Character?](), greenKeys = [Character?](), clickedKeys = [Character?]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    layout()
  }


//MARK: - Private

  private func setup() {
    view.backgroundColor = .black
    guesses = Array(repeating: Array(repeating: nil, count: word.count), count: 6)
    guessesBackground = Array(repeating: Array(repeating: .clear, count: word.count), count: 6)
    addViewChild(KeyboardVC)
    addViewChild(BoardVC)
    KeyboardVC.delegate = self
    KeyboardVC.dataSource = self
    BoardVC.dataSource = self
  }

  private func layout() {
    NSLayoutConstraint.activate([
      BoardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      BoardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      BoardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      BoardVC.view.bottomAnchor.constraint(equalTo: KeyboardVC.view.topAnchor),
      BoardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

      KeyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      KeyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      KeyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])

  }

  private func resetGame() {
    word = ["years","happy","small","kings","worry","crazy","shame"].randomElement()!
    guesses = Array(repeating: Array(repeating: nil, count: word.count), count: 6)
    guessesBackground = Array(repeating: Array(repeating: .clear, count: word.count), count: 6)
    clickedKeys = []
    orangeKeys = []
    greenKeys = []

    BoardVC.reloadData()
    KeyboardVC.reloadData()

  }
}

extension ViewController: KeyboardViewControllerDelegate {
  func keyboardViewController(_ controllerView: KeyboardViewController, didTapKey letter: Character) {
    var breaker: Bool = false
    for lineIndex in 0..<guesses.count {
      for letterIndex in 0..<guesses[lineIndex].count {
        if guesses[lineIndex][letterIndex] == nil {
          guesses[lineIndex][letterIndex] = letter
          if letterIndex == guesses[lineIndex].count - 1 {
            checkLine(lineIndex, letterIndex)
            KeyboardVC.reloadData()
          }
          breaker = true
          break
        }
      }
      if breaker {
        break
      }
    }
    BoardVC.reloadData()
  }

  private func checkLine(_ lineIndex: Int, _ letterIndex: Int) {

    var victory: Bool = true

    for (index, wordLetter) in word.uppercased().enumerated() {
      if let letter = guesses[lineIndex][index] {
        if word.uppercased().contains(letter) {
          guessesBackground[lineIndex][index] = .systemOrange
          orangeKeys.append(guesses[lineIndex][index])
          if wordLetter == letter {
              guessesBackground[lineIndex][index] = .systemGreen
              greenKeys.append(guesses[lineIndex][index])
              victory = victory && true
          } else {
            victory = victory && false
          }
        } else {
            guessesBackground[lineIndex][index] = .clear
            clickedKeys.append(guesses[lineIndex][index])
          victory = victory && false
        }
      }
    }
    if victory {
      let alert = UIAlertController(title: "Vectory", message: "you find the word : \(word)", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: NSLocalizedString("reset", comment: "Default action"), style: .default, handler: { _ in
        self.resetGame()
      }))
      self.present(alert, animated: true, completion: nil)

    }
  }

}



extension ViewController: BoardCollectionViewDataSource {
  var currentGuessesBackground: [[UIColor?]] {
    return guessesBackground
  }

  var currentGuesses: [[Character?]] {
    return guesses
  }

}

extension ViewController: KeyboardViewControllerDataSource {
  func keyColor(letter: Character) -> UIColor? {
    var keyColor: UIColor = .darkGray
    for key in clickedKeys where key == letter {
      keyColor = .systemGray2
    }
    for key in orangeKeys where key == letter {
      keyColor = .systemOrange
    }
    for key in greenKeys where key == letter {
      keyColor = .systemGreen
    }
    return keyColor
  }


}
