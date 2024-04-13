import Cocoa

// Класс для управления ресурсами изображений, реализующий шаблон Singleton для централизованного доступа к изображениям.
class ImageResourceManager {
  
  // Общий экземпляр класса для доступа к изображениям.
  static let shared = ImageResourceManager()
  
  // Приватный инициализатор, предотвращающий создание экземпляров класса извне.
  private init() {}
  
  // Загружает изображение по указанному имени и расширению файла.
  // - Parameters:
  //   - imageName: Имя файла изображения.
  //   - fileExtension: Расширение файла изображения.
  // - Returns: Изображение типа NSImage или nil, если изображение не найдено.
  func loadImage(named imageName: String, withExtension fileExtension: String) -> NSImage? {
    
    // Получаем доступ к bundle, где хранятся ресурсы.
    guard let bundle = Bundle(identifier: "com.artesanoalejo.CoinRotationScreenSaver"),
          
          // Пытаемся найти путь к файлу изображения в bundle.
          let imagePath = bundle.path(forResource: imageName, ofType: fileExtension),
          
          // Загружаем изображение из найденного файла.
          let image = NSImage(contentsOfFile: imagePath) else {
            
            // В случае ошибки выводим сообщение в консоль и возвращаем nil.
            print("Изображение \(imageName).\(fileExtension) не найдено.")
            return nil
          }
    
    // Возвращаем загруженное изображение.
    return image
  }
}




