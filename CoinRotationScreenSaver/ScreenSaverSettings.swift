//
//  ScreenSaverSettings.swift
//  CoinRotationScreenSaver
//
//  Created by Alejo Artesano on 11.04.2024.
//

import Foundation

class ScreenSaverSettings {
  static let shared = ScreenSaverSettings()
  
  private init() {}
  
  private let rotationSpeedKey = "rotationSpeed"
  
  func saveRotationSpeed(_ speed: Float) {
    UserDefaults.standard.set(speed, forKey: rotationSpeedKey)
  }
  
  func loadRotationSpeed() -> Float {
    let defaultSpeed: Float = 0.25 // Значение по умолчанию для скорости вращения
    return UserDefaults.standard.float(forKey: rotationSpeedKey) != 0 ? UserDefaults.standard.float(forKey: rotationSpeedKey) : defaultSpeed
  }
}

