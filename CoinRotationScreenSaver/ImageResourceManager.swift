//
//  ImageResourceManager.swift
//  CoinRotationScreenSaver
//
//  Created by Alejo Artesano on 11.04.2024.
//

import Cocoa

class ImageResourceManager {
  static let shared = ImageResourceManager()
  
  private init() {}
  
  // Метод для загрузки изображения
  func loadImage(named imageName: String, withExtension fileExtension: String) -> NSImage? {
    guard let bundle = Bundle(identifier: "com.artesanoalejo.CoinRotationScreenSaver"),
          let imagePath = bundle.path(forResource: imageName, ofType: fileExtension),
          let image = NSImage(contentsOfFile: imagePath) else {
            print("Изображение \(imageName).\(fileExtension) не найдено.")
            return nil
          }
    return image
  }
}



