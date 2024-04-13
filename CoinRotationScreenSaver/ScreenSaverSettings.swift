import Foundation

// Класс для управления настройками скринсейвера, используя шаблон Singleton.
class ScreenSaverSettings {
  
  // Общий экземпляр класса для доступа к настройкам скринсейвера.
  static let shared = ScreenSaverSettings()
  
  // Приватный инициализатор для предотвращения создания экземпляров извне.
  private init() {}
  
  // Ключ для сохранения и загрузки скорости вращения в UserDefaults.
  private let rotationSpeedKey = "rotationSpeed"
  
  // Сохраняет скорость вращения в UserDefaults.
  // - Parameter speed: Скорость вращения, которую необходимо сохранить.
  func saveRotationSpeed(_ speed: Float) {
    UserDefaults.standard.set(speed, forKey: rotationSpeedKey)
  }
  
  // Загружает скорость вращения из UserDefaults.
  // Возвращает значение по умолчанию, если настройка не была найдена.
  // - Returns: Загруженная скорость вращения или значение по умолчанию.
  func loadRotationSpeed() -> Float {
    let defaultSpeed: Float = 0.25 // Значение по умолчанию для скорости вращения
    return UserDefaults.standard.float(forKey: rotationSpeedKey) != 0 ? UserDefaults.standard.float(forKey: rotationSpeedKey) : defaultSpeed
  }
}


