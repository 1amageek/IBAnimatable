//
//  Created by Jake Lin on 3/3/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

/**
 The interactive gesture type
 */
public enum InteractiveGestureType {
  case `default`          // Will use the default interactive gesture type from `AnimatedTransitioning`
  case pan(fromDirection: GestureDirection)
  case screenEdgePan(fromDirection: GestureDirection)
  case pinch(direction: GestureDirection)
  
  var stringValue: String {
    return String(describing: self)
  }
  
  public static func fromString(_ interactiveGestureType: String) -> InteractiveGestureType? {
    if interactiveGestureType.hasPrefix("default") {
      return .default
    } else if interactiveGestureType.hasPrefix("pan") || interactiveGestureType.hasPrefix("screenEdgePan") ||
      interactiveGestureType.hasPrefix("pinch") {
      return fromStringWithDirection(interactiveGestureType)
    }
    return nil
  }
  
  // Return the `String` without qualification
  public func toString() -> String {
    let namespace = "IBAnimatable." + String(describing: GestureDirection.self) + "."
    return String(describing: self).replacingOccurrences(of: namespace, with: "")
  }
}

// MARK: - InteractiveGestureType from string

private extension InteractiveGestureType {
  static func cleanInteractiveGestureType(_ interactiveGestureType: String) -> String {
    let range = interactiveGestureType.range(of: "(")
    let interactiveGestureType = interactiveGestureType.replacingOccurrences(of: " ", with: "").lowercased()
      .substring(from: range?.lowerBound ?? interactiveGestureType.endIndex)
      .replacingOccurrences(of: "(", with: "")
      .replacingOccurrences(of: ")", with: "")
      .capitalized
    return interactiveGestureType
  }
  
  static func fromStringWithDirection(_ interactiveGestureType: String) -> InteractiveGestureType? {
    let gestureDirectionString = cleanInteractiveGestureType(interactiveGestureType)
    
    guard let direction = GestureDirection(rawValue: gestureDirectionString) else {
      return nil
    }
    
    if interactiveGestureType.hasPrefix("pan") {
      return .pan(fromDirection: direction)
    } else if interactiveGestureType.hasPrefix("screenEdgePan") {
      return .screenEdgePan(fromDirection: direction)
    } else if interactiveGestureType.hasPrefix("pinch") {
      return .pinch(direction: direction)
    }
    
    return nil
  }

}
