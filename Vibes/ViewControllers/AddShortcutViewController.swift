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

class AddShortcutViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var emojiLabel: UILabel!
  
  @IBOutlet weak var drawingView1: DrawingView!
  @IBOutlet weak var drawingView2: DrawingView!
  @IBOutlet weak var drawingView3: DrawingView!
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var selectedEmoji: String?
  
  private var drawingViews: [DrawingView] = []
  private var minimumNumberOfDrawingsRequired: Int {
    return drawingViews.count
  }
  
  private var drawingDataStore: DrawingDataStore!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    drawingViews = [drawingView1, drawingView2, drawingView3]
    drawingView1?.delegate = self
    drawingView2?.delegate = self
    drawingView3?.delegate = self
    if let selectedEmoji = selectedEmoji {
      emojiLabel.text = selectedEmoji
      drawingDataStore = DrawingDataStore(
        for: selectedEmoji,
        capacity: minimumNumberOfDrawingsRequired)
    }
    saveButton.isEnabled = false
  }
  
  // MARK: - Actions
  @IBAction func savePressed(_ sender: Any) {
    // TBD
  }
}

// MARK: - DrawingViewDelegate
extension AddShortcutViewController: DrawingViewDelegate {
  func drawingDidChange(_ drawingView: DrawingView) {
    if let index = drawingViews.firstIndex(of: drawingView) {
      let drawingRect = drawingView.boundingSquare()
      let drawing = Drawing(drawing: drawingView.canvasView.drawing, rect: drawingRect)
      drawingDataStore.addDrawing(drawing, at: index)
      saveButton.isEnabled =
        drawingDataStore.numberOfDrawings >= minimumNumberOfDrawingsRequired
    }
  }
}
