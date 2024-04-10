//
//  CoinRotationScreenSaverView.swift
//  CoinRotationScreenSaver
//
//  Created by Alejo Artesano on 10.04.2024.
//

import ScreenSaver
import Cocoa

class CoinRotationScreenSaverView: ScreenSaverView {
  
  var coinLayer: CALayer?
  var coinImage: NSImage?
  
  // Инициализатор для создания view программно
  override init?(frame: NSRect, isPreview: Bool) {
    super.init(frame: frame, isPreview: isPreview)
    
    self.coinImage = self.loadImage()
    setupCoinLayer() // Настраиваем слой с монетой
  }
  
  // Инициализатор для создания view из Interface Builder
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.coinImage = self.loadImage()
    setupCoinLayer() // Настраиваем слой с монетой
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
  
  
  private func setupCoinLayer() {
    guard let coinImage = self.coinImage else { return }
    
    let layer = CALayer()
    layer.contents = coinImage
    layer.frame = CGRect(x: 0, y: 0, width: coinImage.size.width, height: coinImage.size.height)
    layer.contentsGravity = .resizeAspect
    self.wantsLayer = true // Указываем, что view будет использовать слой
    self.layer = CALayer() // Создаем корневой слой, если он еще не был создан
    self.layer?.addSublayer(layer) // Добавляем слой с монетой в корневой слой
    self.coinLayer = layer
    
    // Центрирование слоя монеты
    layer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
  }

  
  
  // Метод, вызываемый для анимации Screen Saver
  override func animateOneFrame() {
    super.animateOneFrame()

    setNeedsDisplay(bounds) // Перерисовка для обновления содержимого
  }

}
