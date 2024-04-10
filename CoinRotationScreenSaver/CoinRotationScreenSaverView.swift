//
//  CoinRotationScreenSaverView.swift
//  CoinRotationScreenSaver
//
//  Created by Alejo Artesano on 10.04.2024.
//

import ScreenSaver
import Cocoa

class CoinRotationScreenSaverView: ScreenSaverView {
  
  var coinImage: NSImage?
  
  // Инициализатор для создания view программно
  override init?(frame: NSRect, isPreview: Bool) {
    super.init(frame: frame, isPreview: isPreview)
    self.coinImage = self.loadImage()
  }
  
  // Инициализатор для создания view из Interface Builder
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.coinImage = self.loadImage()
  }
  
  // Метод для загрузки изображения
  private func loadImage() -> NSImage? {
    guard let imagePath = Bundle(for: type(of: self)).path(forResource: "BitcoinImage-1024", ofType: "png"),
          let image = NSImage(contentsOfFile: imagePath) else {
            print("Изображение монеты не найдено.")
            return nil
          }
    return image
  }
  
  // Метод для отрисовки содержимого Screen Saver
  override func draw(_ rect: NSRect) {
    super.draw(rect)
    
    guard let image = self.coinImage else {
      NSColor.black.setFill()
      rect.fill()
      return
    }
    
    let imageSize = image.size
    var newImageSize: CGSize = imageSize
    
    // Соотношение сторон изображения
    let imageAspectRatio = imageSize.width / imageSize.height
    
    // Соотношение сторон области отображения
    let viewAspectRatio = rect.width / rect.height
    
    // Масштабирование изображения
    if imageAspectRatio > viewAspectRatio {
      // Если ширина изображения относительно его высоты больше, чем у области отображения,
      // Масштабируем по ширине
      newImageSize.width = rect.width
      newImageSize.height = rect.width / imageAspectRatio
    } else {
      // В противном случае масштабируем по высоте
      newImageSize.height = rect.height
      newImageSize.width = rect.height * imageAspectRatio
    }
    
    // Расчет положения для центрирования изображения
    let imageRect = CGRect(
      x: rect.midX - newImageSize.width / 2,
      y: rect.midY - newImageSize.height / 2,
      width: newImageSize.width,
      height: newImageSize.height
    )
    
    // Отрисовка изображения
    image.draw(in: imageRect, from: NSRect.zero, operation: .sourceOver, fraction: 1.0)
  }


  
  
  // Метод, вызываемый для анимации Screen Saver
  override func animateOneFrame() {
    super.animateOneFrame()
    // Здесь можно добавить логику анимации
    setNeedsDisplay(bounds) // Перерисовка для обновления содержимого
  }
  
  // Дополнительные методы, если необходимо...
}
