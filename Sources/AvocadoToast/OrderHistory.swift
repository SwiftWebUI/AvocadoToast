//
//  OrderHistory.swift
//  AvocadoToast
//
//  Created by Helge Heß on 27.06.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

import SwiftWebUI

struct SaltIcon: View {
  let body = Text("🧂")
}
struct RedPepperFlakesIcon: View {
  let body = Text("🌶")
}

struct OrderCell: View {
  let order : CompletedOrder
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(order.summary)
        Text(order.purchaseDate)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      Spacer()
      if order.includeSalt {
        SaltIcon()
      }
      else {}
      if order.includeRedPepperFlakes {
        RedPepperFlakesIcon()
      }
      else {}
    }
  }
}

struct OrderHistory: View {
  let previousOrders : [ CompletedOrder ]
  
  var body: some View {
    NavigationView(emptyView: OrderDetail(order: previousOrders[0])) {
      List(previousOrders) { order in
        NavigationLink(destination: OrderDetail(order: order)) {
          OrderCell(order: order)
        }
      }
    }
  }
}
