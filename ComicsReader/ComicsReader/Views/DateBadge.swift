//
//  DateBadge.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import SwiftUI

struct DateBadge: View {
    
    let comic: IdentifiableComic
    
    func comicDate(_ comic: IdentifiableComic) -> String {
        let day = comic.day.count == 1 ? "0" + comic.day : comic.day
        let month = comic.month.count == 1 ? "0" + comic.month : comic.month
        let year = comic.year
        
        return day + "/" + month + "/" + year
    }
    
    var body: some View {
        Text(comicDate(comic))
            .font(.caption)
            .fontWeight(.semibold)
            .padding(4)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .cornerRadius(6)
            .frame(idealWidth: 40)
            .padding(.bottom, 10)
    }
}

#if DEBUG
//struct DateBadge_Previews: PreviewProvider {
//    static var previews: some View {
//        DateBadge(comic: )
//    }
//}
#endif
