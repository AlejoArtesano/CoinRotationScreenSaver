import ScreenSaver
import Cocoa

class CoinRotationScreenSaverView: ScreenSaverView {
  
  var coinLayer: CALayer?
  var coinImage: NSImage?
  
  // Инициализатор для создания view программно
  override init?(frame: NSRect, isPreview: Bool) {
    super.init(frame: frame, isPreview: isPreview)
    
    // Установка свойства для использования слоёв во view, что необходимо для анимации
    self.wantsLayer = true
    
    // Загрузка изображения монеты для использования в скринсейвере
    self.coinImage = ImageResourceManager.shared.loadImage(named: "BitcoinImage-1024", withExtension: "png")
    
    // Загрузка текущей скорости вращения из настроек и сохранение её обратно (можно использовать для миграции или обновления значений)
    let speed = ScreenSaverSettings.shared.loadRotationSpeed()
    ScreenSaverSettings.shared.saveRotationSpeed(speed)
    
    // Вызываем метод настройки слоёв и анимации для монеты
    setupCoinLayer()
  }
  
  // Инициализатор для создания view из Interface Builder
  required init?(coder: NSCoder) {
    super.init(coder: coder)

    // Вызываем метод настройки слоёв и анимации для монеты
    setupCoinLayer()
  }
  
  
  // Настройка слоёв и анимации для монеты
  private func setupCoinLayer() {
    // Проверяем, загружено ли изображение монеты
    guard let coinImage = self.coinImage else { return }
    
    // Создание и конфигурация слоя для отображения монеты
    let layer = CALayer()
    layer.contents = coinImage // Назначаем изображение содержимым слоя
    layer.contentsGravity = .resizeAspect // Устанавливаем режим масштабирования содержимого слоя
    
    // Если у view ещё нет слоя, создаём и назначаем новый
    self.layer = self.layer ?? CALayer()
    self.layer?.addSublayer(layer) // Добавляем созданный слой с монетой в корневой слой view
    
    self.coinLayer = layer // Сохраняем ссылку на слой с монетой для дальнейшего использования
    
    // Вызываем методы для адаптации размера слоя и добавления анимации вращения
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
    layer.frame = CGRect(x: bounds.midX - layerWidth / 2,
                         y: bounds.midY - layerHeight / 2,
                         width: layerWidth, height: layerHeight)
  }
  

  // Добавляем анимацию вращения
  private func addRotationAnimation() {
    guard let layer = self.coinLayer else { return }
    
    // Получение текущей скорости вращения
    let rotationSpeed = ScreenSaverSettings.shared.loadRotationSpeed()
    
    // Создание и настройка анимации вращения
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y") // Анимация вращения вокруг оси Y
    rotationAnimation.fromValue = 0 // Начальное значение угла вращения
    rotationAnimation.toValue = CGFloat.pi * 2 // Конечное значение угла (полный оборот)
    rotationAnimation.duration = CFTimeInterval(1.0 / rotationSpeed) // Применяем загруженную скорость
    rotationAnimation.repeatCount = .infinity // Анимация будет повторяться бесконечно
    
    // Применение анимации к слою
    layer.add(rotationAnimation, forKey: "rotationAnimation")
  }

  
  // Метод, вызываемый для анимации Screen Saver
  override func animateOneFrame() {
    super.animateOneFrame()
  }
  
}
