//
//  CTAButton.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

struct CTAButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            Text(title)
                .foregroundColor(Color.white)
        }
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 4)
        .background(
            Capsule()
                .foregroundColor(Color.orange))
    }
}
