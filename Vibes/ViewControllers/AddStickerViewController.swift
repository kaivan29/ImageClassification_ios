/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

private let reuseIdentifier = "EmojiCell"

let emoji = """
  😀,😂,🤣,😅,😆,😉,😊,😎,😍,😘,🥰,🙂,
  🤗,🤩,🤔,😐,😑,🙄,😣,😥,😮,🤐,😯,😪,
  😫,😴,😛,😝,😓,🤑,☹️,😖,😤,😭,😨,😩,
  🤯,😬,😰,😱,🥵,🥶,😳,🤪,😵,😡,🤬,😷,
  🤒,🤕,🤢,🤮,🤧,😇,🤠,🤡,🥳,🤫,😈,👿,
  👹,👺,💀,👻,👽,🤖,💩,🙌🏼,🙏🏼,👍🏼,👎🏼,👊🏼,
  👋🏼,🤙🏼,💪🏼
  """
  .components(separatedBy: ",")

class AddStickerViewController: UICollectionViewController {
  var selectedEmoji: String?
  
  // MARK: - Lifecycle
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddShortcutSegue" {
      if let destinationViewController =
        segue.destination as? AddShortcutViewController,
        let selectedEmoji = selectedEmoji {
        destinationViewController.selectedEmoji = selectedEmoji
      }
    }
  }
  
  // MARK: - Actions
  @IBAction func cancelPressed(_ sender: Any) {
    dismiss(animated: true)
  }
}

// MARK: - UICollectionViewDataSource
extension AddStickerViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return emoji.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    if let cell = cell as? EmojiViewCell {
      cell.emoji = emoji[indexPath.item]
    }
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension AddStickerViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    selectedEmoji = emoji[indexPath.item]
    performSegue(withIdentifier: "AddStickerUnwindSegue", sender: self)
  }
}
