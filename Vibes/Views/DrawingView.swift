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
import PencilKit

class DrawingView: UIView {
  // MARK: - Properties
  var canvasView: PKCanvasView!
  weak var delegate: DrawingViewDelegate?
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPencilKitCanvas()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupPencilKitCanvas()
  }

}

// MARK: - Private methods
private extension DrawingView {
  func setupPencilKitCanvas() {
    canvasView = PKCanvasView(frame: self.bounds)
    canvasView.backgroundColor = .clear
    canvasView.isOpaque = false
    canvasView.delegate = self
    canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
    addSubview(canvasView)
  }
}

// MARK: - Helper methods
extension DrawingView {
  func boundingSquare() -> CGRect {
    let rect = canvasView.drawing.bounds
    let dimension = max(rect.size.width, rect.size.height)
    // Adjust each dimension accordingly
    let xInset = (rect.size.width - dimension) / 2
    let yInset = (rect.size.height - dimension) / 2
    // Perform the inset to get the square
    return rect.insetBy(dx: xInset, dy: yInset)
  }
  
  func clearCanvas() {
    canvasView.drawing = PKDrawing()
  }
}

// MARK: - PKCanvasViewDelegate
extension DrawingView: PKCanvasViewDelegate {
  func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
    // If this callback is a result of a cleared
    // drawing, then ignore
    let drawingRect = canvasView.drawing.bounds
    guard drawingRect.size != .zero else {
        return
    }
    delegate?.drawingDidChange(self)
  }
}

// MARK: - Protocol
protocol DrawingViewDelegate: class {
  func drawingDidChange(_ drawingView: DrawingView)
}
