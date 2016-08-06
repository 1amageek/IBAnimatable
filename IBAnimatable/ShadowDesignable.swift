//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/**
  These properties are not able to render in IB correctly, it maybe a bug of IB.
 
  To use them, `UIView`'s `clipsToBounds` and `CALayer`'s `masksToBounds` (`Clip Subviews` in IB) must be `false`,
*/
public protocol ShadowDesignable {
  /**
   `color` when using with `box-shadow`
  */
  var shadowColor: UIColor? { get set }

  /**
    Radius in `box-shadow`
  */
  var shadowRadius: CGFloat { get set }

  /**
   Opacity in `box-shadow`: from 0 to 1
  */
  var shadowOpacity: CGFloat { get set }

  /**
   Offset in `box-shadow`. `x` is horizontal offset and `y` is vertical offset
  */
  var shadowOffset: CGPoint { get set }
}

public extension ShadowDesignable where Self: UIView {
  public func configShadowColor() {
    if let unwrappedShadowColor = shadowColor {
      commonSetup()
      layer.shadowColor = unwrappedShadowColor.CGColor
    }
  }

  public func configShadowRadius() {
    if !shadowRadius.isNaN && shadowRadius > 0 {
      commonSetup()
      layer.shadowRadius = shadowRadius
    }
  }

  public func configShadowOpacity() {
    if !shadowOpacity.isNaN && shadowOpacity >= 0 && shadowOpacity <= 1 {
      commonSetup()
      layer.shadowOpacity = Float(shadowOpacity)
    }
  }

  public func configShadowOffset() {
    if !shadowOffset.x.isNaN {
      commonSetup()
      layer.shadowOffset.width = shadowOffset.x
    }
    
    if !shadowOffset.y.isNaN {
      commonSetup()
      layer.shadowOffset.height = shadowOffset.y
    }
  }
  
  public func configMaskShadow() {
    commonSetup()
    // if a layer mask is specified, display the shadow to match the mask
    if let mask = layer.mask as? CAShapeLayer {
      if let unwrappedShadowColor = shadowColor {
//        layer.shadowColor = unwrappedShadowColor.CGColor
//        mask.shadowColor = unwrappedShadowColor.CGColor
      }
      if !shadowRadius.isNaN && shadowRadius > 0 {
        mask.shadowRadius = shadowRadius
      }
      if !shadowOpacity.isNaN && shadowOpacity >= 0 && shadowOpacity <= 1 {
        mask.shadowOpacity = Float(shadowOpacity)
      }
      if !shadowOffset.x.isNaN {
        mask.shadowOffset.width = shadowOffset.x
      }
      if !shadowOffset.y.isNaN {
        mask.shadowOffset.height = shadowOffset.y
      }
      mask.shadowPath = mask.path
    }
  }
  
  private func commonSetup() {
    // Need to set `layer.masksToBounds` to `false`. 
    // If `layer.masksToBounds == true` then shadow doesn't work any more.
    if layer.masksToBounds {
      layer.masksToBounds = false
    }
  }
}
