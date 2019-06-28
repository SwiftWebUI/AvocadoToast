//
//  Model.swift
//  AvocadoToast
//
//  Created by Helge Heß on 28.06.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

import protocol SwiftWebUI.Identifiable

struct Order {
  var includeSalt            = false
  var includeRedPepperFlakes = false
  var quantity               = 0
  var avocadoStyle           = AvocadoStyle.sliced
  var spread                 = Spread.none
  var breadType              = BreadType.wheat
}

struct CompletedOrder: Identifiable {
  var id           : Int
  var summary      : String
  var purchaseDate : String
  var includeSalt            = false
  var includeRedPepperFlakes = false
}


enum AvocadoStyle {
  case sliced, mashed
}

enum BreadType: CaseIterable, Hashable, Identifiable {
  case wheat, white, rhy
  
  var name: String { return "\(self)".capitalized }
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
