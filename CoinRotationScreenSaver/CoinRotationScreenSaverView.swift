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
    self.wantsLayer = true // Указывает, что view использует layer-backed rendering.
    self.coinImage = ImageResourceManager.shared.loadImage(named: "BitcoinImage-1024",
                                                           withExtension: "png")
    
    let speed = ScreenSaverSettings.shared.loadRotationSpeed()
    ScreenSaverSettings.shared.saveRotationSpeed(speed) // Теперь это будет использовать новый класс
    
    setupCoinLayer() // Настраиваем слой с монетой
  }
  
  // Инициализатор для создания view из Interface Builder
  required init?(coder: NSCoder) {
    super.init(coder: coder)

    setupCoinLayer() // Настраиваем слой с монетой
  }
  
  
  private func setupCoinLayer() {
    guard let coinImage = self.coinImage else { return }
    
    let layer = CALayer()
    layer.contents = coinImage
    layer.contentsGravity = .resizeAspect // Указываем, как содержимое должно масштабироваться внутри слоя
    self.layer = self.layer ?? CALayer() // Убедитесь, что у view есть корневой слой
    self.layer?.addSublayer(layer)
    self.coinLayer = layer
    
    adjustLayerSize()
    addRotationAnimation()
  }

  // Расчет адаптивного размера и позиционирования слоя
  private func adjustLayerSize() {
    guard let layer = self.coinLayer, let coinImage = self.coinImage else { return }
    
    // Рассчитываем размеры, чтобы изображение полностью поместилось в экран, сохраняя пропорции
    let aspectRatio = coinImage.size.width / coinImage.size.height
    var layerWidth: CGFloat
    var layerHeight: CGFloat
    
    // Предпочтение масштабированию по ширине или высоте в зависимости от соотношения сторон
    if aspectRatio > 1 { // Шире, чем высоко
      layerWidth = min(bounds.width, coinImage.size.width)
      layerHeight = layerWidth / aspectRatio
    } else { // Выше, чем шире
      layerHeight = min(bounds.height, coinImage.size.height)
      layerWidth = layerHeight * aspectRatio
    }
    
    // Центрируем слой
    layer.frame = CGRect(x: bounds.midX - layerWidth / 2, y: bounds.midY - layerHeight / 2,
                         width: layerWidth, height: layerHeight)
  }
  

  // Добавляем анимацию вращения
  private func addRotationAnimation() {
    guard let layer = self.coinLayer else { return }
    
    let rotationSpeed = ScreenSaverSettings.shared.loadRotationSpeed()
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
    rotationAnimation.fromValue = 0 // Начальное значение угла вращения
    rotationAnimation.toValue = CGFloat.pi * 2 // Конечное значение угла (полный оборот)
    rotationAnimation.duration = CFTimeInterval(1.0 / rotationSpeed) // Применяем загруженную скорость
    rotationAnimation.repeatCount = .infinity // Анимация будет повторяться бесконечно
    
    layer.add(rotationAnimation, forKey: "rotationAnimation")
  }

  
  // Метод, вызываемый для анимации Screen Saver
  override func animateOneFrame() {
    super.animateOneFrame()

    setNeedsDisplay(bounds) // Перерисовка для обновления содержимого
  }
}
