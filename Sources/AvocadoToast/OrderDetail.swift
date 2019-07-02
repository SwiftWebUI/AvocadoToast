//
//  OrderDetail.swift
//  AvocadoToast
//
//  Created by Helge Heß on 28.06.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

import SwiftWebUI

struct OrderDetail: View {
  let order : CompletedOrder

  var body: some View {
    VStack {
      Text(order.summary).font(.title)

      VStack(alignment: .leading) {
        Text(order.purchaseDate)
      
        HStack {
          if order.includeSalt {
            SaltIcon()
          }
          else {}
          if order.includeRedPepperFlakes {
            RedPepperFlakesIcon()
          }
          else {}
        }
        
        Spacer()
        
        Image.unsplash(size  : UXSize(width: 480, height: 320),
                       terms : order.summary
                               .components(separatedBy: " ")
                               .filter { $0 != "with" })
      }
    }
  }
}
