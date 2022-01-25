//
//  ContentView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-20.
//

import SwiftUI
import Combine
import ShortcutFoundation

struct ContentView: View {
    @ObservedObject var model: MainViewModel
    @State private var showFullImage = false
    @State var presentingSearchSheet = false
    @EnvironmentObject var searchSettings: SearchSettings
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        let filter = "Showing all Comics"
        
        return NavigationView {
            List {
                Section(header: Text(filter).padding(.leading, -10)) {
                    ForEach(self.model.comics) { comic in
                        NavigationLink(destination: FullScreenImageView(imageUrl: comic.img)) {
                            VStack(alignment: .leading, spacing: 4) {
                                ListCellHeaderView(comic: comic)
                                ListCellContentView(comic: comic)
                                ListCellButtonView(comic: comic)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            .listStyle(PlainListStyle())
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $presentingSearchSheet) {
                SearchView(
                    searchCompleted: { searchKey in
                    guard let number = Int(searchKey) else {
                        self.searchSettings.searchText = searchKey
                        self.presentingSearchSheet = false
                        return
                    }
                    self.searchSettings.issueNumber = number
                    self.presentingSearchSheet = false
                },
                    resetSearchCompleted: { _, resetText in
                        self.searchSettings.issueNumber = 0
                        self.searchSettings.searchText = resetText
                        self.presentingSearchSheet = false
                })
                    .frame(minHeight: 0, maxHeight: 400, alignment: .center)
            }
            .navigationBarTitle(Text("\(self.model.comics.count) Comics found"))
            .navigationBarItems(
                leading: Button("Search") {
                    presentingSearchSheet = true
                },
                trailing: Button("Favorites") {
                })
        }
//        Rectangle
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: MainViewModel())
    }
}
#endif
