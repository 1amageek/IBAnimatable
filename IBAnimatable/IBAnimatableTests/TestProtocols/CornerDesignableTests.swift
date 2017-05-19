//
//  CornerDesignableTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

// MARK: - CornerDesignableTests Protocol

protocol CornerDesignableTests: class {

  func testCornerRadius()
  func test_cornerSides()

}

// MARK: - Universal Tests

extension CornerDesignableTests {

  func _test_cornerSides(_ element: StringCornerDesignable) {
    element._cornerSides = "topLeft"
    XCTAssertEqual(element.cornerSides, .topLeft)
    element._cornerSides = "topRight"
    XCTAssertEqual(element.cornerSides, .topRight)
    element._cornerSides = "bottomLeft"
    XCTAssertEqual(element.cornerSides, .bottomLeft)
    element._cornerSides = "bottomRight"
    XCTAssertEqual(element.cornerSides, .bottomRight)
    element._cornerSides = "allSides"
    XCTAssertEqual(element.cornerSides, .allSides)
    element._cornerSides = ""
    XCTAssertEqual(element.cornerSides, .allSides)
  }

}

// MARK: - UIView Tests

extension CornerDesignableTests {

  func _testCornerRadius<E: UIView>(_ element: E) where E: CornerDesignable {
    element.cornerRadius = 3.0
    element.cornerSides = .allSides
    XCTAssertEqual(element.cornerRadius, element.layer.cornerRadius)
    element.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    let mask = element.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: element.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let cornerRadii = CGSize(width: element.cornerRadius, height: element.cornerRadius)
    let corners: UIRectCorner = [.bottomLeft, .bottomRight, .topLeft]
    let mockPath = UIBezierPath(roundedRect: element.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
    XCTAssertEqual(mask?.path, mockPath)
  }

}

// MARK: - UICollectionViewCell Tests

extension CornerDesignableTests {

  func _testCornerRadius<E: UICollectionViewCell>(_ element: E) where E: CornerDesignable {
    element.cornerRadius = -1
    XCTAssertFalse(element.contentView.layer.masksToBounds)
    element.cornerRadius = 3.0
    XCTAssertNil(element.layer.mask)
    XCTAssertEqual(element.layer.cornerRadius, 0.0)
    element.cornerSides = .allSides
    XCTAssertEqual(element.contentView.layer.cornerRadius, element.cornerRadius)
    element.cornerSides = [.bottomLeft, .bottomRight, .topLeft]
    XCTAssertEqual(element.contentView.layer.cornerRadius, 0.0)
    let mask = element.contentView.layer.mask as? CAShapeLayer
    XCTAssertEqual(mask?.frame, CGRect(origin: .zero, size: element.bounds.size))
    XCTAssertEqual(mask?.name, "cornerSideLayer")
    let cornerRadii = CGSize(width: element.cornerRadius, height: element.cornerRadius)
    let corners: UIRectCorner = [.bottomLeft, .bottomRight, .topLeft]
    let mockPath = UIBezierPath(roundedRect: element.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
    XCTAssertEqual(mask?.path, mockPath)
    XCTAssertTrue(element.contentView.layer.masksToBounds)
  }

}
