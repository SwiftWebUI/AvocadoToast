//
//  AvocadoApp.swift
//  AvocadoToast
//
//  Created by Helge Heß on 28.06.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

import SwiftWebUI

struct MainPage: View {
  
  /// One store per `MainPage`, i.e. per session when the page is created
  /// in the `serve` closure.
  let store = OrderStore()
  
  var body: some View {
    TabView {
      
      OrderPage()
        .tabItem(Text("Order"))
      
      OrderHistory()
        .tabItem(Text("History"))
    }
    .padding()
    .relativeWidth(0.95)
    .relativeHeight(0.95)
    .environmentObject(store)
  }
}
