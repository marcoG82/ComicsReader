//
//  SearchView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

///Both newSearchText and newSearchIssue are used to filter the always present (in the viewModel)  array of comics. Just never at the same time
struct SearchView: View {
    @State var newSearchText = ""
    @State var newSearchIssue = ""
    
    let searchCompleted: (String) -> Void
    let resetSearchCompleted: (String, String) -> Void
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Search comics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            TextField("", text: $newSearchText)
                .padding(8)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                .padding()
            
            CTAButton(title: "Search by Text") {
                guard self.newSearchText != "" else {
                    self.searchCompleted(self.newSearchText)
                    return
                }
                self.searchCompleted(self.newSearchText)
                self.newSearchText = ""
            }
            
            TextField("", text: $newSearchIssue)
                .keyboardType(.numberPad)
                .padding(8)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                .padding()
            
            CTAButton(title: "Search by Issue") {
                guard self.newSearchIssue != "" else {
                    self.newSearchIssue = "0"
                    self.searchCompleted(self.newSearchIssue)
                    return
                }
                self.searchCompleted(self.newSearchIssue)
                self.newSearchIssue = ""
            }
            
            CTAButton(title: "Reset Search") {
                self.newSearchIssue = "0"
                self.newSearchText = ""
                self.resetSearchCompleted(self.newSearchIssue, self.newSearchText)
                self.newSearchIssue = ""
            }
            Spacer()
        }
    }
}
