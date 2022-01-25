//
//  ListCellButtonView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

struct ListCellButtonView: View {
    let comic: IdentifiableComic
    
    var body: some View {
        HStack {
            CTAButton(title: "Share") {
                
            }
            Spacer()
            CTAButton(title: "Save to Favorites") {
                
            }
        }
    }
}
