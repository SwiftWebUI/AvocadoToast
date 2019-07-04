//
//  OrderPage.swift
//  AvocadoToast
//
//  Created by Helge Heß on 27.06.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

import SwiftWebUI

struct OrderPage: View {
  
  @State var order = Order()
  
  func submitOrder() {
  }
  
  var body: some View {
    Form {
      Section(header: Text("Avocado Toast").font(.title)) {
        Picker(selection: $order.breadType, label: Text("Bread")) {
          ForEach(BreadType.allCases) { breadType in
            Text(breadType.name).tag(breadType)
          }
        }
        .pickerStyle(.radioGroup)
        
        Picker(selection: $order.avocadoStyle, label: Text("Avocado")) {
          Text("Sliced").tag(AvocadoStyle.sliced)
          Text("Mashed").tag(AvocadoStyle.mashed)
        }
        .pickerStyle(.radioGroup)
        
        Picker(selection: $order.spread, label: Text("Spread")) {
          ForEach(Spread.allCases) { spread in
            Text(spread.name).tag(spread) // there is no .name?!
          }
        }
      }
      
      Section {
        Toggle(isOn: $order.includeSalt) {
          Text("Include Salt")
        }
        Toggle(isOn: $order.includeRedPepperFlakes) {
          Text("Include Red Pepper Flakes")
        }
        Stepper(value: $order.quantity, in: 1...10) {
          Text("Quantity: \(order.quantity)")
        }
      }
      Section {
        Button(action: submitOrder) {
          Text("🍞")
          Text("Order")
        }
      }
    }.padding()
  }
}
