//
//  CatFactsMediumWidgetView.swift
//  CatFactsWidgetExtension
//
//  Created by Daniel Yount on 9/8/20.
//

import SwiftUI
import WidgetKit

struct CatFactsWidgetMediumView: View {

    let entry: CatFactsWidgetProvider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("🐈 Cat Facts")
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

struct CatFactsMediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactsWidgetMediumView(entry: CatFactWidgetEntry(date: Date(), catFact: CatFact(fact: "A fun fact here!")))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
