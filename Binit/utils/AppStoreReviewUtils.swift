//
//  AppStoreReviewUtils.swift
//  Binit
//
//  Created by Nikita on 21.10.2023.
//

import Foundation
import StoreKit

enum AppStoreReviewUtils {
  static func requestReviewIfAppropriate() {
      SKStoreReviewController.requestReview()
  }
}
