//
//  Model.swift
//  AvocadoToast
//
//  Created by Helge Heß on 28.06.19.
//  Copyright © 2019-2024 ZeeZide GmbH. All rights reserved.
//

import Foundation
import SwiftWebUI
// Foundation re-exports Combine on Apple platforms, which brings in its own
// `ObservableObject`. The scoped import makes SwiftWebUI's take precedence.
import protocol SwiftWebUI.ObservableObject
#if canImport(Combine)
  import class Combine.PassthroughSubject
#elseif canImport(OpenCombine)
  import class OpenCombine.PassthroughSubject
#endif

struct Order {
  var includeSalt            = false
  var includeRedPepperFlakes = false
  var quantity               = 1
  var avocadoStyle           = AvocadoStyle.sliced
  var spread                 = Spread.none
  var breadType              = BreadType.wheat

  /// E.g. "Rye with Almond Butter" or "Wheat Toast", like the sample orders.
  var summary : String {
    let base = spread == .none
      ? "\(breadType.name) Toast"
      : "\(breadType.name) with \(spread.name)"
    return quantity > 1 ? "\(quantity)× \(base)" : base
  }
}

/// Holds the completed orders of a session. Views observe it using
/// `@EnvironmentObject`, `submitOrder` on the order page appends to it.
final class OrderStore: ObservableObject {

  let didChange = PassthroughSubject<Void, Never>()

  private(set) var completedOrders : [ CompletedOrder ] {
    didSet { didChange.send(()) }
  }

  init(completedOrders: [ CompletedOrder ] = previousOrders) {
    self.completedOrders = completedOrders
  }

  func complete(_ order: Order) {
    let nextID = (completedOrders.map { $0.id }.max() ?? 0) + 1
    let completed = CompletedOrder(
      id: nextID, summary: order.summary, purchaseDate: Self.today(),
      includeSalt: order.includeSalt,
      includeRedPepperFlakes: order.includeRedPepperFlakes
    )
    completedOrders.append(completed)
  }

  private static func today() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
  }
}

struct CompletedOrder: Identifiable {
  var id                     : Int
  var summary                : String
  var purchaseDate           : String
  var includeSalt            = false
  var includeRedPepperFlakes = false
}


enum AvocadoStyle {
  case sliced, mashed
}

enum BreadType: CaseIterable, Hashable, Identifiable {
  case wheat, white, rhy
  
  var name: String { return "\(self)".capitalized }
  var id : Self { self }
}

enum Spread: CaseIterable, Hashable, Identifiable {
  case none, almondButter, peanutButter, honey
  case almou, tapenade, hummus, mayonnaise
  case kyopolou, adjvar, pindjur
  case vegemite, chutney, cannedCheese, feroce
  case kartoffelkase, tartarSauce

  var name: String {
    return "\(self)".map { $0.isUppercase ? " \($0)" : "\($0)" }
      .joined().capitalized
  }
  var id : Self { self }
}

let previousOrders : [ CompletedOrder ] = [
  .init(id:  1, summary: "Rye with Almond Butter",  purchaseDate: "2019-05-30"),
  .init(id:  2, summary: "Multi-Grain with Hummus", purchaseDate: "2019-06-02",
        includeRedPepperFlakes: true),
  .init(id:  3, summary: "Sourdough with Chutney",  purchaseDate: "2019-06-08",
        includeSalt: true, includeRedPepperFlakes: true),
  .init(id:  4, summary: "Rye with Peanut Butter",  purchaseDate: "2019-06-09"),
  .init(id:  5, summary: "Wheat with Tapenade",     purchaseDate: "2019-06-12"),
  .init(id:  6, summary: "Sourdough with Vegemite", purchaseDate: "2019-06-14",
        includeSalt: true),
  .init(id:  7, summary: "Wheat with Féroce",       purchaseDate: "2019-06-31"),
  .init(id:  8, summary: "Rhy with Honey",          purchaseDate: "2019-07-03"),
  .init(id:  9, summary: "Multigrain Toast",        purchaseDate: "2019-07-04",
        includeSalt: true),
  .init(id: 10, summary: "Sourdough with Chutney",  purchaseDate: "2019-07-06")
]
