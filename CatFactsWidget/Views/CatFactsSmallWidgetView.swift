//
//  CatFactsSmallWidgetView.swift
//  CatFactsWidgetExtension
//
//  Created by Daniel Yount on 9/8/20.
//

import SwiftUI
import WidgetKit

struct CatFactsWidgetSmallView: View {

    var entry: CatFactsWidgetProvider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("🐈 Cat Fact")
                    .font(.headline)
                    .bold()
                Spacer()
            }
            Spacer()
            Text(entry.catFact.fact)
                .font(.subheadline)
                .minimumScaleFactor(0.5)
        }
        .padding()
    }
}

struct CatFactsSmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactsWidgetSmallView(entry: CatFactsWidgetProvider.Entry(date: Date(), catFact: CatFact(fact: "A fact here!")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
