//
//  CoinRotationScreenSaverView.swift
//  CoinRotationScreenSaver
//
//  Created by Alejo Artesano on 10.04.2024.
//

import ScreenSaver

class CoinRotationScreenSaverView: ScreenSaverView {
  
  override init?(frame: NSRect, isPreview: Bool) {
    super.init(frame: frame, isPreview: isPreview)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func draw(_ rect: NSRect) {
    super.draw(rect)
    
    // Заполнение фона заставки цветом
    let backgroundColor = NSColor.black
    backgroundColor.setFill()
    rect.fill()
    
    // Демонстрация текста
    let text = "Coin Rotation Screen Saver"
    let attributes = [
      NSAttributedString.Key.font: NSFont.systemFont(ofSize: 24),
      NSAttributedString.Key.foregroundColor: NSColor.white
    ]
    
    let textSize = text.size(withAttributes: attributes)
    let textRect = CGRect(x: rect.midX - textSize.width / 2, y: rect.midY - textSize.height / 2, width: textSize.width, height: textSize.height)
    
    text.draw(in: textRect, withAttributes: attributes)
  }
  
  override func animateOneFrame() {
    super.animateOneFrame()
  }
}
