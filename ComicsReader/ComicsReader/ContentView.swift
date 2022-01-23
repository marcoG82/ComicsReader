//
//  ContentView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var model: MainViewModel
    @State var presentingSettingsSheet = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var currentDate = Date()
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        let filter = "Showing all stories"
        
        return NavigationView {
            List {
                Section(header: Text(filter).padding(.leading, -10)) {
                    ForEach(self.model.comics) { comic in
                        VStack(alignment: .leading, spacing: 10) {
                            DateBadge(comic: comic)
                            
                            Text(comic.title)
                                .frame(minHeight: 0, maxHeight: 100)
                                .font(.title)
                            
                            Button(comic.img) {
                                print(comic)
                            }
                            .font(.subheadline)
                            .foregroundColor(self.colorScheme == .light ? .blue : .orange)
                            .padding(.top, 6)
                        }
                        .padding()
                    }
                }.padding()
            }
            .listStyle(PlainListStyle())
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle(Text("\(self.model.comics.count) Comics"))
            .navigationBarItems(trailing:
                                    Button("Settings") {
                self.presentingSettingsSheet = true
            }
            )
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: MainViewModel())
    }
}
#endif
