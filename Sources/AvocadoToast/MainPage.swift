//
//  AvocadoApp.swift
//  AvocadoToast
//
//  Created by Helge Heß on 28.06.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

import SwiftWebUI

struct MainPage: View {
  
  var body: some View {
    TabbedView {
      
      OrderPage()
        .tabItem(Text("Order"))
      
      OrderHistory(previousOrders: previousOrders)
        .tabItem(Text("History"))
    }
    .padding()
    .relativeWidth(0.95)
    .relativeHeight(0.95)
  }
}
